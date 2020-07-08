import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/stream.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  final Store store;

  /// id of current podcast
  final String id;

  /// urlParam of current podcast;
  final String urlParam;

  /// This is used to apply updates to screenData
  final PodcastActionsBloc podcastActionsBloc;

  /// Controller for screen data
  final BehaviorSubject<PodcastScreenData> _screenData =
      BehaviorSubject<PodcastScreenData>();

  /// Stream for episode pages
  final PaginationStream<Episode> _episodePagesStream =
      PaginationStream<Episode>();

  /// Subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;
  StreamSubscription<dynamic> _podcastActionsSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.urlParam,
    @required this.podcastActionsBloc,
  }) : id = getIdFromUrlParam(urlParam) {
    /// load data from streams
    _handleDataFromStore();

    /// Handle any changes as a result of podcast actions
    _handlePodcastActions();
  }

  Future<void> _handleDataFromStore() async {
    _storeSubscription = Rx.combineLatest3<Podcast, Subscription,
        List<List<Episode>>, PodcastScreenData>(
      store.podcast.watchByUrlParam(urlParam),
      store.subscription.watchByPodcast(id),
      _episodePagesStream.stream,
      (podcast, subscription, episodesPages) => PodcastScreenData(
        podcast: podcast,
        episodes: episodesPages.expand((x) => x).toList(),
        isSubscribed: subscription != null,
        receivedAllEpisodes: episodesPages.length == 1
            ? episodesPages.first.length < 15
            : episodesPages.last.length < 30,
      ),
    ).distinct().listen(_screenData.add);

    if (!_episodePagesStream.containsPage(0)) {
      _episodePagesStream.addStream(
        0,
        store.episode.watchByPodcastPaginated(
          podcastId: id,
          offset: 0,
          limit: 15,
        ),
      );
    }
  }

  void _handlePodcastActions() {
    _podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (action) => action.whenPartial(
        subscribed: (data) async {
          if (data.podcastId == id) {
            final screenData = await _screenData.first;
            if (!screenData.isSubscribed) {
              _screenData.add(screenData.copyWith(isSubscribed: true));
            }
          }
        },
        unsubscribed: (data) async {
          if (data.podcastId == id) {
            final screenData = await _screenData.first;
            if (screenData.isSubscribed) {
              _screenData.add(screenData.copyWith(isSubscribed: false));
            }
          }
        },
      ),
    );
  }

  /// Sink to load more episodes
  void loadMoreEpisodes() async {
    final screenData = await _screenData.first;
    final offset = screenData.episodes.length;

    if (!_episodePagesStream.containsPage(offset)) {
      _episodePagesStream.addStream(
        offset,
        store.episode.watchByPodcastPaginated(
          podcastId: id,
          offset: offset,
          limit: 30,
        ),
      );
    }
  }

  /// Stream of ScreenData
  Stream<PodcastScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _storeSubscription.cancel();
    await _podcastActionsSubscription.cancel();
  }
}
