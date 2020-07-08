import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

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

  /// [_episodePageOffsets] contains offsets of pages in episodePageGroup
  /// EpisodePageStreams are added to _episodePageGroup when required
  final Set<int> _episodePageOffsets = {};
  final StreamGroup<Tuple2<int, List<Episode>>> _episodePageGroup =
      StreamGroup<Tuple2<int, List<Episode>>>();

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
    final episodePagesMap =
        _episodePageGroup.stream.scan<Map<int, List<Episode>>>(
      (acc, tup, _) => {...acc, tup.item1: tup.item2},
      {},
    );

    _storeSubscription = Rx.combineLatest3<Podcast, Subscription,
        List<List<Episode>>, PodcastScreenData>(
      store.podcast.watchByUrlParam(urlParam),
      store.subscription.watchByPodcast(id),
      episodePagesMap.map((m) => m.values.toList()),
      (podcast, subscription, episodesPages) => PodcastScreenData(
        podcast: podcast,
        episodes: episodesPages.expand((x) => x).toList(),
        isSubscribed: subscription != null,
        receivedAllEpisodes: episodesPages.length == 1
            ? episodesPages.first.length < 15
            : episodesPages.last.length < 30,
      ),
    ).where((x) => x.episodes.isNotEmpty).distinct().listen(_screenData.add);

    _watchEpisodePage(0, 15);
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

  void _watchEpisodePage(int offset, int limit) {
    if (_episodePageOffsets.contains(offset)) {
      return;
    }

    _episodePageOffsets.add(offset);
    _episodePageGroup.add(
      store.episode
          .watchByPodcastPaginated(
            podcastId: id,
            offset: offset,
            limit: limit,
          )
          .map((x) => Tuple2(offset, x)),
    );
  }

  /// Sink to load more episodes
  void loadMoreEpisodes() async {
    final screenData = await _screenData.first;
    final offset = screenData.episodes.length;
    _watchEpisodePage(offset, 30);
  }

  /// Stream of ScreenData
  Stream<PodcastScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _storeSubscription.cancel();
    await _podcastActionsSubscription.cancel();
  }
}
