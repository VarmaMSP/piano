import 'package:phenopod/model/main.dart';

abstract class Store {
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  AudioPlayerStore get audioPlayer;
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

abstract class AudioPlayerStore {
  Future<void> saveSnapshot(AudioPlayerSnapshot snapshot);
  Future<AudioPlayerSnapshot> getSnapshotOnce();
  Stream<AudioPlayerSnapshot> getSnapshot();
  Future<AudioTrack> getNowPlaying();
}
