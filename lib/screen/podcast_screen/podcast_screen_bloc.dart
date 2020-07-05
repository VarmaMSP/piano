import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  final Store store;

  /// urlParam of current podcast;
  final String urlParam;

  /// This is used to apply updates to podcast
  final PodcastActionsBloc podcastActionsBloc;

  /// controller for podcast
  final BehaviorSubject<Podcast> _podcast = BehaviorSubject<Podcast>();

  /// controller for episodes
  final BehaviorSubject<List<Episode>> _episodes =
      BehaviorSubject<List<Episode>>();

  /// This flag is turned on when [dispose()] is invoked
  /// Because the podcast screen widget can dispose this bloc at any
  /// time, check this flag before pushing values into stream controllers
  /// to avoid exceptions
  bool _isDisposed = false;

  /// Subscriptions to podcast actions
  StreamSubscription<dynamic> _podcastActionsSubscription;
  StreamSubscription<dynamic> _podcastDbSubscription;
  StreamSubscription<dynamic> _episodeDbSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.urlParam,
    @required this.podcastActionsBloc,
  }) {
    /// Handle changes from db
    _handleChangesFromDb();

    /// Handle any changes as a result of podcast actions
    _handlePodcastActions();
  }

  void _handleChangesFromDb() {
    _podcastDbSubscription =
        store.podcast.watchByUrlParam(urlParam).listen(_podcast.add);
    _episodeDbSubscription = store.episode
        .watchByPodcastPaginated(
          podcastId: getIdFromUrlParam(urlParam),
          offset: 0,
          limit: 15,
        )
        .listen(_episodes.add);
  }

  void _handlePodcastActions() {
    _podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (action) => action.whenPartial(
        subscribed: (data) async {
          if (data.podcastUrlParam == urlParam) {
            final screenData = await _podcast.first;
            if (!screenData.isSubscribed) {
              _podcast.add(screenData.copyWith(isSubscribed: true));
            }
          }
        },
        unsubscribed: (data) async {
          if (data.podcastUrlParam == urlParam) {
            final screenData = await _podcast.first;
            if (screenData.isSubscribed) {
              _podcast.add(screenData.copyWith(isSubscribed: false));
            }
          }
        },
      ),
    );
  }

  /// load more episodes
  Future<void> loadMoreEpisodes() async {
    final podcast = await _podcast.first;
    final episodes = await store.episode
        .watchByPodcastPaginated(
          podcastId: podcast.id,
          offset: podcast.episodes.length,
          limit: 30,
        )
        .first;

    if (!_isDisposed) {
      _podcast.add(podcast.copyWith(
        episodes: podcast.episodes + episodes,
      ));
    }
  }

  Stream<Podcast> get podcast => _podcast.stream;

  Stream<List<Episode>> get episodes => _episodes.stream;

  /// Screen data
  Stream<Podcast> get screenData => _podcast.stream;

  Future<void> dispose() async {
    await _podcast.close();
    await _episodes.close();
    await _podcastActionsSubscription.cancel();
    await _podcastDbSubscription.cancel();
    await _episodeDbSubscription.cancel();
    _isDisposed = true;
  }
}
