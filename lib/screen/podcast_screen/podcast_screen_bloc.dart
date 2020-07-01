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
  final BehaviorSubject<Podcast> _podcast = BehaviorSubject<Podcast>();

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

  void _loadScreen() {
    store.podcast.watch(urlParam).listen((p) async {
      if (!_isDisposed) {
        _podcast.add(p);
      }
    });
  }

  /// load more episodes
  Future<void> loadMoreEpisodes() async {
    final podcast = await _podcast.first;
    final episodes = await store.episode.getByPodcastPaginated(
      podcast.id,
      podcast.episodes.length,
      30,
    );

    if (!_isDisposed) {
      _podcast.add(podcast.copyWith(
        episodes: podcast.episodes + episodes,
      ));
    }
  }

  /// Screen data
  Stream<Podcast> get screenData => _podcast.stream;

  Future<void> dispose() async {
    await _podcast.close();
    await _podcastActionsSubscription.cancel();
    _isDisposed = true;
  }
}
