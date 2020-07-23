// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/stream.dart';
import 'package:phenopod/utils/utils.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  final Store store;
  final EventBus eventBus;

  /// id of current podcast
  final String id;

  /// urlParam of current podcast;
  final String urlParam;

  /// Controller for screen data
  final BehaviorSubject<PodcastScreenData> _screenData =
      BehaviorSubject<PodcastScreenData>();

  /// Stream for episode pages
  final StreamMap<int, List<Episode>> _episodePageMap =
      StreamMap<int, List<Episode>>();

  /// Subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;
  StreamSubscription<dynamic> _eventSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.eventBus,
    @required this.urlParam,
  }) : id = getIdFromUrlParam(urlParam) {
    /// load data from streams
    _handleDataFromStore();

    /// Handle any changes as a result of podcast actions
    _handleEvents();
  }

  Future<void> _handleDataFromStore() async {
    _storeSubscription = Rx.combineLatest3<Podcast, Subscription,
        List<List<Episode>>, PodcastScreenData>(
      store.podcast.watchByUrlParam(urlParam),
      store.subscription.watchByPodcast(id),
      _episodePageMap.streamValues,
      (podcast, subscription, episodesPages) => PodcastScreenData(
        podcast: podcast,
        episodes: episodesPages.expand((x) => x).toList(),
        isSubscribed: subscription != null,
        receivedAllEpisodes: episodesPages.length == 1
            ? podcast.cachedAllEpisodes && episodesPages.first.length < 15
            : podcast.cachedAllEpisodes && episodesPages.last.length < 30,
      ),
    ).distinct().listen(_screenData.add);

    _episodePageMap.add(
      0,
      store.episode
          .watchByPodcastPaginated(podcastId: id, offset: 0, limit: 15)
          .where((e) => e.isNotEmpty),
    );
  }

  void _handleEvents() {
    _eventSubscription = eventBus.on().listen((e) {
      (e as AppEvent).maybeMap(
        subscribeToPodcast: (data) async {
          if (data.podcast.id == id) {
            final screenData = await _screenData.first;
            if (!screenData.isSubscribed) {
              _screenData.add(screenData.copyWith(isSubscribed: true));
            }
          }
        },
        unsubscribeFromPodcast: (data) async {
          if (data.podcast.id == id) {
            final screenData = await _screenData.first;
            if (screenData.isSubscribed) {
              _screenData.add(screenData.copyWith(isSubscribed: false));
            }
          }
        },
        orElse: () {},
      );
    });
  }

  /// Sink to load more episodes
  void loadMoreEpisodes() async {
    final screenData = await _screenData.first;
    final offset = screenData.episodes.length;

    if (!_episodePageMap.contains(offset)) {
      _episodePageMap.add(
        offset,
        StreamDelayTill<List<Episode>>(
          store.episode.watchByPodcastPaginated(
            podcastId: id,
            offset: offset,
            limit: 30,
          ),
          (episodes) => episodes.isNotEmpty,
        ).stream,
      );
    }
  }

  /// Stream of ScreenData
  Stream<PodcastScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _storeSubscription.cancel();
    await _eventSubscription.cancel();
  }
}
