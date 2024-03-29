// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/stream.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  final Store store;
  final EventBus eventBus;

  /// Controller for screen data
  final BehaviorSubject<PodcastScreenData> _screenData =
      BehaviorSubject<PodcastScreenData>();

  /// Stream for episode pages
  final StreamMap<int, List<Episode>> _episodePageMap =
      StreamMap<int, List<Episode>>();

  /// Stream for podcast
  Stream<Podcast> _podcastStream;

  /// Subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;
  StreamSubscription<dynamic> _eventSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.eventBus,
    @required String urlParam,
  }) {
    /// load data from streams
    _handleDataFromStore(urlParam);

    /// Handle any changes as a result of podcast actions
    _handleEvents();
  }

  Future<void> _handleDataFromStore(String urlParam) async {
    _podcastStream = store.podcast.watchByUrlParam(urlParam);
    _storeSubscription = Rx.combineLatest3<Podcast, Subscription,
        List<List<Episode>>, PodcastScreenData>(
      _podcastStream,
      Rx.switchLatest<Subscription>(
        _podcastStream
            .where((p) => p != null)
            .map((p) => store.subscription.watchByPodcast(p.id)),
      ),
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
      Rx.switchLatest<List<Episode>>(
        _podcastStream.where((p) => p != null).map(
              (p) => store.episode
                  .watchByPodcastPaginated(
                    podcastId: p.id,
                    offset: 0,
                    limit: 15,
                  )
                  .where((e) => e.isNotEmpty),
            ),
      ),
    );
  }

  void _handleEvents() {
    _eventSubscription = eventBus.on().listen((e) {
      (e as AppEvent).maybeMap(
        subscribeToPodcast: (data) async {
          final screenData = await _screenData.first;
          final podcast = screenData.podcast;
          final isSubscribed = screenData.isSubscribed;
          if (data.podcast.id == podcast.id && !isSubscribed) {
            _screenData.add(screenData.copyWith(isSubscribed: true));
          }
        },
        unsubscribeFromPodcast: (data) async {
          final screenData = await _screenData.first;
          final podcast = screenData.podcast;
          final isSubscribed = screenData.isSubscribed;
          if (data.podcast.id == podcast.id && isSubscribed) {
            _screenData.add(screenData.copyWith(isSubscribed: false));
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
        Rx.switchLatest<List<Episode>>(
          _podcastStream.where((p) => p != null).map(
                (p) => StreamDelayTill<List<Episode>>(
                  store.episode.watchByPodcastPaginated(
                    podcastId: p.id,
                    offset: offset,
                    limit: 30,
                  ),
                  (episodes) => episodes.isNotEmpty,
                ).stream,
              ),
        ),
      );
    }
  }

  /// Stream of ScreenData
  Stream<PodcastScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _storeSubscription.cancel();
    await _eventSubscription.cancel();
    await _screenData.close();
  }
}
