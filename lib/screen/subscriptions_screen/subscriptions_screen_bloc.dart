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
  final BehaviorSubject<SubscriptionsScreenData> _screenData =
      BehaviorSubject<SubscriptionsScreenData>();

  StreamSubscription<dynamic> _podcastActionsSubscription;

  SubscriptionsScreenBloc({
    @required this.store,
    @required this.podcastActionsBloc,
  }) {
    /// Load screen data
    _loadScreen();

    /// Listen to new subscriptions
    _handlePodcastActions();
  }

  void _handlePodcastActions() {
    _podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (action) => action.whenPartial(
        subscribed: (data) async {
          if (data.synced) {
            await _loadScreen();
          }
        },
        unsubscribed: (data) async {
          if (data.synced) {
            await _loadScreen();
          }
        },
      ),
    );
  }

  Future<void> _loadScreen() async {
    final screenData = await store.subscription.getScreenData();
    _screenData.add(screenData);
  }

  /// Get Screen data
  Stream<SubscriptionsScreenData> get screenData => _screenData.stream;

  Future<void> dispose() async {
    await _screenData.close();
    await _podcastActionsSubscription.cancel();
  }
}
