import 'package:phenopod/model/main.dart';

abstract class Store {
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  AudioPlayerStore get audioPlayer;
  PlaybackPositionStore get playbackPosition;
  PreferenceStore get preference;
  TaskQueueStore get taskQueue;
}

abstract class UserStore {
  Future<User> getSignedInUser();
  Future<void> signInWithGuest(GuestCredentials credentials);
  Future<void> signInWithGoogle(
      {String idToken, GuestCredentials guestCredentials});
  Future<void> signInWithFacebook(
      {String accessToken, GuestCredentials guestCredentials});
}

abstract class PodcastStore {
  Future<Podcast> get_(String podcastUrlParam);
  Stream<Podcast> watch(String podcastUrlParam);
  Stream<Podcast> watch_(String urlParam);
  Future<void> refresh(String urlParam);
  Future<void> cache(String _urlParam);
  Future<bool> isCached({String id, String urlParam});
  Future<void> deleteCache({String id, String urlParam});
}

abstract class EpisodeStore {
  Future<void> saveAll(List<Episode> episodes);
  Future<List<Episode>> getByPodcastPaginated(
      String podcastId, int offset, int limit);
  Stream<List<Episode>> watchByPodcast(String podcastId);
  Future<List<Episode>> getFromSubscriptionsPaginated(int offset, int limit);
}

abstract class SubscriptionStore {
  Future<void> subscribe(Podcast podcast);
  Future<void> unsubscribe(Podcast podcast);
  Future<SubscriptionsFeed> getFeed();
  Stream<SubscriptionsFeed> watchFeed();
  Future<void> updateFeed();
}

abstract class AudioPlayerStore {
  Future<void> saveQueue(Queue queue);
  Future<void> saveSetting(AudioPlayerSetting setting);
  Future<Queue> getQueue();
  Stream<Queue> watchQueue();
  Future<AudioTrack> getNowPlaying();
  Future<AudioPlayerSetting> getSetting();
  Stream<AudioPlayerSetting> watchSetting();
}

abstract class PlaybackPositionStore {
  Future<void> save(PlaybackPosition playback);
  Future<void> update(PlaybackPosition playback);
  Future<PlaybackPosition> get_(String episodeId);
  Stream<PlaybackPosition> watch(String episodeId);
}

abstract class PreferenceStore {
  Future<void> saveAudioSetting(AudioPlayerSetting setting);
  Future<AudioPlayerSetting> getAudioSetting();
  Stream<AudioPlayerSetting> watchAudioSetting();
}

abstract class TaskQueueStore {
  Stream<Task> watchFront();
  Future<void> pop();
}
