import 'package:phenopod/store/store.dart';

import 'podcast_api.dart';
import 'episode_api.dart';
import 'subscription_api.dart';
import 'user_api.dart';

class ApiStore extends Store {
  final UserStore _userStore = UserApi();
  final PodcastStore _podcastStore = PodcastApi();
  final EpisodeStore _episodeStore = EpisodeApi();
  final SubscriptionStore _subscriptionStore = SubscriptionApi();

  @override
  UserStore get user => _userStore;

  @override
  PodcastStore get podcast => _podcastStore;

  @override
  EpisodeStore get episode => _episodeStore;

  @override
  SubscriptionStore get subscription => _subscriptionStore;
}
