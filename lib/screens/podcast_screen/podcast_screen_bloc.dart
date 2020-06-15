import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/subjects.dart';

/// This bloc is used to represent local state of podcast screen
class PodcastScreenBloc {
  /// urlParam of current podcast;
  final String urlParam;

  /// This is used to apply updates to podcast
  final PodcastActionsBloc podcastActionsBloc;

  /// controller for podcast
  final BehaviorSubject<Podcast> _podcast = BehaviorSubject<Podcast>();

  /// controller for episode
  final BehaviorSubject<List<Episode>> _episodes =
      BehaviorSubject<List<Episode>>();

  /// stream to flag that all episodes are loaded
  final BehaviorSubject<bool> _receivedAllEpisodes = BehaviorSubject<bool>();

  /// This flag is turned on when [dispose()] is invoked
  /// Because the podcast screen widget can dispose this bloc at any
  /// time, check this flag before pushing values into stream controllers
  /// to avoid exceptions
  bool _isDisposed = false;

  /// Subscriptions to podcast actions
  StreamSubscription<Podcast> _subSubscription;
  StreamSubscription<Podcast> _unsubSubscription;

  PodcastScreenBloc({
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
        if (!await _podcast.isEmpty && !_isDisposed) {
          _podcast.add((await _podcast.first).copyWith(isSubscribed: true));
        }
      },
    );

    _unsubSubscription = podcastActionsBloc.latestUnsubscription
        .where((podcast) => podcast.urlParam == urlParam)
        .listen(
      (_) async {
        if (!await _podcast.isEmpty && !_isDisposed) {
          _podcast.add((await _podcast.first).copyWith(isSubscribed: false));
        }
      },
    );
  }

  Future<void> _loadPage() async {
    final response = await makeRequest(
      method: 'GET',
      path: '/podcasts/$urlParam',
    );

    if (!_isDisposed) {
      _podcast.add(response.podcasts[0]);
      _episodes.add(response.episodes);
      _receivedAllEpisodes.add(response.episodes.length < 15);
    }
  }

  /// load more episodes
  Future<void> loadMoreEpisodes() async {
    final podcast = await _podcast.first;
    final episodes = await _episodes.first;
    final response = await makeRequest(
      method: 'GET',
      path: '/ajax/browse',
      queryParams: <String, String>{
        'endpoint': 'podcast_episodes',
        'podcast_id': podcast.id,
        'offset': episodes.length.toString(),
        'limit': '30',
        'order': 'pub_date_desc',
      },
    );

    if (!_isDisposed) {
      _episodes.add(episodes + response.episodes);
      _receivedAllEpisodes.add(response.episodes.length < 30);
    }
  }

  /// Current podcast
  Stream<Podcast> get podcast => _podcast.stream;

  /// Episodes for current podcast
  Stream<List<Episode>> get episodes => _episodes.stream;

  /// Flag if all episodes are loaded
  Stream<bool> get receivedAllEpisodes => _receivedAllEpisodes.stream;

  Future<void> dispose() async {
    await _podcast.close();
    await _episodes.close();
    await _receivedAllEpisodes.close();
    await _subSubscription.cancel();
    await _unsubSubscription.cancel();
    _isDisposed = true;
  }
}
