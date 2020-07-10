import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/stream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

class SubscriptionsScreenBloc {
  final Store store;

  /// used to listen to subscription updates
  final PodcastActionsBloc podcastActionsBloc;

  /// Controller of screen data
  final BehaviorSubject<SubscriptionsScreenData> _screenData =
      BehaviorSubject<SubscriptionsScreenData>();

  /// Stream of episode pages
  final StreamMap<int, List<Episode>> _episodePageStreamMap =
      StreamMap<int, List<Episode>>();

  /// Stream of subscribed podcasts
  Stream<List<Podcast>> _subscriptionsStream;

  /// Subscriptions made in this bloc
  StreamSubscription<dynamic> _storeSubscription;
  StreamSubscription<dynamic> _podcastActionsSubscription;

  SubscriptionsScreenBloc({
    @required this.store,
    @required this.podcastActionsBloc,
  }) {
    /// load data from store
    _watchStore();

    /// Listen to new subscriptions
    _handlePodcastActions();
  }

  void _watchStore() {
    _subscriptionsStream = store.podcast.watchSubscribed();
    _storeSubscription = Rx.combineLatest2<List<Podcast>, List<List<Episode>>,
        SubscriptionsScreenData>(
      _subscriptionsStream,
      _episodePageStreamMap.streamValues,
      (subscriptions, episodePages) => SubscriptionsScreenData(
        podcasts: subscriptions,
        episodes: episodePages.expand((x) => x).toList(),
        receivedAllEpisodes: episodePages.last.length < 30,
      ),
    ).distinct().listen(_screenData.add);

    _episodePageStreamMap.add(
      0,
      Rx.switchLatest<List<Episode>>(
        _subscriptionsStream.map(
          (podcasts) => store.episode.watchByPodcastsPaginated(
            podcastIds: podcasts.map((x) => x.id).toList(),
            offset: 0,
            limit: 30,
          ),
        ),
      ),
    );
  }

  void _handlePodcastActions() {
    _podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (action) => action.whenPartial(
        subscribed: (data) async {
          if (data.synced) {
            // await _loadScreen();
          }
        },
        unsubscribed: (data) async {
          if (data.synced) {
            // await _loadScreen();
          }
        },
      ),
    );
  }

  /// Sink to load more episodes
  void loadMoreEpisodes() async {
    final screenData = await _screenData.first;
    final offset = screenData.episodes.length;

    if (!_episodePageStreamMap.contains(offset)) {
      _episodePageStreamMap.add(
        offset,
        Rx.switchLatest<List<Episode>>(
          _subscriptionsStream.map(
            (podcasts) => store.episode.watchByPodcastsPaginated(
              podcastIds: podcasts.map((x) => x.id).toList(),
              offset: offset,
              limit: 30,
            ),
          ),
        ),
      );
    }
  }

  /// Stream of ScreenData
  Stream<SubscriptionsScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _storeSubscription.cancel();
    await _podcastActionsSubscription.cancel();
  }
}
