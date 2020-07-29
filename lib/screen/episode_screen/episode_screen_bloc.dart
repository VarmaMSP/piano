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

class EpisodeScreenBloc {
  final Store store;
  final EventBus eventBus;

  // controller for screen data
  final BehaviorSubject<EpisodeScreenData> _screenData =
      BehaviorSubject<EpisodeScreenData>();

  // subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;
  StreamSubscription<dynamic> _eventSubscription;

  EpisodeScreenBloc({
    @required this.store,
    @required this.eventBus,
    @required String urlParam,
  }) {
    /// load data from streams
    _handleDataFromStore(urlParam);

    /// Handle any changes as a result of podcast actions
    _handleEvents();
  }

  void _handleDataFromStore(String urlParam) async {
    final episodeStream = store.episode.watchByUrlParam(urlParam);
    final podcastStream = Rx.switchLatest<Podcast>(
      episodeStream
          .where((e) => e != null)
          .map((e) => store.podcast.watchById(e.podcastId)),
    );
    final epiosdeMetaStream = Rx.switchLatest<EpisodeMeta>(
      episodeStream
          .where((e) => e != null)
          .map((e) => store.episode.watchMeta(e.id)),
    );
    final subscriptionStream = Rx.switchLatest<Subscription>(
      podcastStream
          .where((p) => p != null)
          .map((p) => store.subscription.watchByPodcast(p.id)),
    );

    _storeSubscription = Rx.combineLatest4<Episode, Podcast, EpisodeMeta,
        Subscription, EpisodeScreenData>(
      episodeStream,
      podcastStream,
      epiosdeMetaStream,
      subscriptionStream,
      (episode, podcast, episodeMeta, subscription) => EpisodeScreenData(
        episode: episode,
        podcast: podcast,
        episodeMeta: episodeMeta,
        isPodcastSubscribed: subscription != null,
      ),
    ).distinct().listen(_screenData.add);
  }

  void _handleEvents() {
    _eventSubscription = eventBus.on().listen((e) {
      (e as AppEvent).maybeMap(
        subscribeToPodcast: (data) async {
          final screenData = await _screenData.first;
          final podcast = screenData.podcast;
          final isSubscribed = screenData.isPodcastSubscribed;
          if (data.podcast.id == podcast.id && !isSubscribed) {
            _screenData.add(screenData.copyWith(isPodcastSubscribed: true));
          }
        },
        unsubscribeFromPodcast: (data) async {
          final screenData = await _screenData.first;
          final podcast = screenData.podcast;
          final isSubscribed = screenData.isPodcastSubscribed;
          if (data.podcast.id == podcast.id && isSubscribed) {
            _screenData.add(screenData.copyWith(isPodcastSubscribed: false));
          }
        },
        orElse: () {},
      );
    });
  }

  /// Stream of screenData
  Stream<EpisodeScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _storeSubscription.cancel();
    await _eventSubscription.cancel();
    await _screenData.close();
  }
}
