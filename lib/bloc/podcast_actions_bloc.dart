import 'package:phenopod/models/main.dart';
import 'package:phenopod/repositories/subscription.dart';
import 'package:rxdart/subjects.dart';

class PodcastActionsBloc {
  final SubscriptionRepository _subscriptionRepository =
      SubscriptionRepository();

  // Contoller for podcast subscription actions
  final BehaviorSubject<Podcast> _subscribeTo = BehaviorSubject<Podcast>();

  // Controller for podcast unsubscription actions
  final BehaviorSubject<Podcast> _unsubscribeTo = BehaviorSubject<Podcast>();

  PodcastActionsBloc() {
    _handleSubscribeActions();
    _handleUnsubscribeActions();
  }

  void _handleSubscribeActions() {
    _subscribeTo.stream.listen((podcast) async {
      print('Subscribe');
      print(podcast.title);
      await _subscriptionRepository.subscribe(podcast.id);
    });
  }

  void _handleUnsubscribeActions() {
    _unsubscribeTo.stream.listen((podcast) async {
      print('Unsubscribe');
      print(podcast.title);
      await _subscriptionRepository.unsubscribe(podcast.id);
    });
  }

  // Subscribe to podcast
  void Function(Podcast) get subscribe => _subscribeTo.add;

  // Unsubscribe to podcast
  void Function(Podcast) get unsubscribe => _unsubscribeTo.add;

  // Stream representing latest subscriptions
  Stream<Podcast> get latestSubscription => _subscribeTo.stream;

  // Stream representing latest unsubscriptions
  Stream<Podcast> get latestUnsubscription => _unsubscribeTo.stream;

  Future<void> dispose() async {
    await _subscribeTo.close();
    await _unsubscribeTo.close();
  }
}
