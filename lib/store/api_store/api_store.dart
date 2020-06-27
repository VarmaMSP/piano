import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/store/store.dart';

import 'podcast_api.dart';
import 'episode_api.dart';
import 'subscription_api.dart';
import 'user_api.dart';

class ApiStore extends Store {
  UserStore _userStore;
  PodcastStore _podcastStore;
  EpisodeStore _episodeStore;
  SubscriptionStore _subscriptionStore;

  ApiStore(HttpClient httpClient) {
    _userStore = UserApi(httpClient);
    _podcastStore = PodcastApi(httpClient);
    _episodeStore = EpisodeApi(httpClient);
    _subscriptionStore = SubscriptionApi(httpClient);
  }

  @override
  UserStore get user => _userStore;

  @override
  PodcastStore get podcast => _podcastStore;

  @override
  EpisodeStore get episode => _episodeStore;

  @override
  SubscriptionStore get subscription => _subscriptionStore;

  @override
  QueueStore get queue => throw UnimplementedError();

  @override
  PlaybackPositionStore get playbackPosition => throw UnimplementedError();

  @override
  PreferenceStore get preference => throw UnimplementedError();

  @override
  TaskStore get task => throw UnimplementedError();
}
