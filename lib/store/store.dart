import 'package:phenopod/model/main.dart';

abstract class Store {
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  QueueStore get queue;
  PlaybackStore get playback;
}

abstract class UserStore {
  Future<User> getSignedInUser();
  Future<void> signInWithGuest();
}

abstract class PodcastStore {
  Future<Podcast> get(String podcastId);
  Future<PodcastScreenData> getScreenData(String podcastUrlParam);
}

abstract class EpisodeStore {
  Future<List<Episode>> getByPodcastPaginated(
      String podcastId, int offset, int limit);
}

abstract class SubscriptionStore {
  Future<void> subscribe(String podcastId);
  Future<void> unsubscribe(String podcastId);
}

abstract class QueueStore {
  Future<void> save(Queue queue);
  Future<Queue> get_();
  Stream<Queue> watch();
  Future<AudioTrack> getNowPlaying();
}

abstract class PlaybackStore {
  Future<void> save(Playback playback);
  Future<void> updateProgress(Playback playback);
  Future<Playback> get_(String episodeId);
  Stream<Playback> watch(String episodeId);
}
