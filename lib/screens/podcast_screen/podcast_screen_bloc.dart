import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  final Store store;

  /// urlParam of current podcast;
  final String urlParam;

  /// This is used to apply updates to podcast
  final PodcastActionsBloc podcastActionsBloc;

  /// controller for podcastScreenData
  final BehaviorSubject<PodcastScreenData> _screenData =
      BehaviorSubject<PodcastScreenData>();

  /// This flag is turned on when [dispose()] is invoked
  /// Because the podcast screen widget can dispose this bloc at any
  /// time, check this flag before pushing values into stream controllers
  /// to avoid exceptions
  bool _isDisposed = false;

  /// Subscriptions to podcast actions
  StreamSubscription<Podcast> _subSubscription;
  StreamSubscription<Podcast> _unsubSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.urlParam,
    @required this.podcastActionsBloc,
  }) {
    /// Handle any changes as a result of podcast actions
    _handlePodcastActions();

    /// Load page data
    _loadPage();
  }

  void _handlePodcastActions() {
    _subSubscription = podcastActionsBloc.latestSubscription
        .where((podcast) => podcast.urlParam == urlParam)
        .listen(
      (_) async {
        if (!await _screenData.isEmpty && !_isDisposed) {
          final data = await _screenData.first;
          final podcast = data.podcast.copyWith(isSubscribed: true);

          _screenData.add(data.copyWith(podcast: podcast));
        }
      },
    );

    _unsubSubscription = podcastActionsBloc.latestUnsubscription
        .where((podcast) => podcast.urlParam == urlParam)
        .listen(
      (_) async {
        if (!await _screenData.isEmpty && !_isDisposed) {
          final data = await _screenData.first;
          final podcast = data.podcast.copyWith(isSubscribed: false);

          _screenData.add(data.copyWith(podcast: podcast));
        }
      },
    );
  }

  Future<void> _loadPage() async {
    final screenData = await store.podcast.getScreenData(urlParam);
    if (!_isDisposed) {
      _screenData.add(screenData);
    }
  }

  /// load more episodes
  Future<void> loadMoreEpisodes() async {
    final data = await _screenData.first;
    final episodes = await store.episode.getByPodcastPaginated(
      data.podcast.id,
      data.episodes.length,
      30,
    );

    if (!_isDisposed) {
      _screenData.add(data.copyWith(
        episodes: data.episodes + episodes,
        receivedAllEpisodes: episodes.length > 30,
      ));
    }
  }

  /// Screen data
  Stream<PodcastScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _subSubscription.cancel();
    await _unsubSubscription.cancel();
    _isDisposed = true;
  }
}
