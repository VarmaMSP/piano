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
  StreamSubscription<dynamic> _podcastActionsSubscription;

  PodcastScreenBloc({
    @required this.store,
    @required this.urlParam,
    @required this.podcastActionsBloc,
  }) {
    /// Handle any changes as a result of podcast actions
    _handlePodcastActions();

    /// Load screen data
    _loadScreen();
  }

  void _handlePodcastActions() {
    _podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (action) => action.whenPartial(
        subscribed: (data) async {
          if (data.podcastUrlParam == urlParam) {
            final screenData = await _screenData.first;
            if (!screenData.podcast.isSubscribed) {
              _screenData.add(screenData.copyWith(
                podcast: screenData.podcast.copyWith(isSubscribed: true),
              ));
            }
          }
        },
        unsubscribed: (data) async {
          if (data.podcastUrlParam == urlParam) {
            final screenData = await _screenData.first;
            if (screenData.podcast.isSubscribed) {
              _screenData.add(screenData.copyWith(
                podcast: screenData.podcast.copyWith(isSubscribed: false),
              ));
            }
          }
        },
      ),
    );
  }

  Future<void> _loadScreen() async {
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
    await _podcastActionsSubscription.cancel();
    _isDisposed = true;
  }
}
