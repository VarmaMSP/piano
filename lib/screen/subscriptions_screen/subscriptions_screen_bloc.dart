import 'package:flutter/foundation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

class SubscriptionsScreenBloc {
  final Store store;

  /// used to listen to subscription updates
  final PodcastActionsBloc podcastActionsBloc;

  /// Stream of subscription screen data
  final BehaviorSubject<SubscriptionsFeed> _subscriptionsFeed =
      BehaviorSubject<SubscriptionsFeed>();

  StreamSubscription<dynamic> _podcastActionsSubscription;

  SubscriptionsScreenBloc({
    @required this.store,
    @required this.podcastActionsBloc,
  }) {
    /// pipe feed from db
    _handleFeedChanges();

    /// Listen to new subscriptions
    _handlePodcastActions();
  }

  void _handleFeedChanges() {
    store.subscription.watchFeed().distinct().listen((feed) {
      _subscriptionsFeed.add(feed);
    });
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

  /// Get feed
  Stream<SubscriptionsFeed> get feed => _subscriptionsFeed.stream;

  Future<void> dispose() async {
    await _subscriptionsFeed.close();
    await _podcastActionsSubscription.cancel();
  }
}
