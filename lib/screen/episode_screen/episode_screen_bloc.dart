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
import 'package:phenopod/utils/utils.dart';

class EpisodeScreenBloc {
  final Store store;
  final EventBus eventBus;

  // id of current episode
  final String id;

  // urlParam of current episode
  final String urlParam;

  // controller for screen data
  final BehaviorSubject<EpisodeScreenData> _screenData =
      BehaviorSubject<EpisodeScreenData>();

  // Stream of episode
  Stream<Episode> _episodeStream;

  // subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;

  EpisodeScreenBloc({
    @required this.store,
    @required this.eventBus,
    @required this.urlParam,
  }) : id = getIdFromUrlParam(urlParam) {
    /// load data from streams
    _handleDataFromStore();
  }

  Future<void> _handleDataFromStore() async {
    _episodeStream = store.episode.watchByUrlParam(urlParam);
    _storeSubscription =
        Rx.combineLatest3<Episode, Podcast, EpisodeMeta, EpisodeScreenData>(
      _episodeStream,
      Rx.switchLatest<Podcast>(
        _episodeStream
            .where((e) => e != null)
            .map((e) => store.podcast.watchById(e.podcastId)),
      ),
      Rx.switchLatest<EpisodeMeta>(
        _episodeStream
            .where((e) => e != null)
            .map((e) => store.episode.watchMeta(e.id)),
      ),
      (episode, podcast, episodeMeta) => EpisodeScreenData(
        episode: episode,
        podcast: podcast,
        episodeMeta: episodeMeta,
      ),
    ).distinct().listen(_screenData.add);
  }

  /// Stream of screenData
  Stream<EpisodeScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _storeSubscription.cancel();
    await _screenData.close();
  }
}
