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
  Future<void> save(Podcast podcast);
  Future<void> saveScreenData(PodcastScreenData screenData);
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam);
  Future<void> deleteScreenData(String podcastId);
  Future<bool> isCached({String id, String urlParam});
}

abstract class EpisodeStore {
  Future<void> saveAll(List<Episode> episodes);
  Future<List<Episode>> getByPodcastPaginated(
      String podcastId, int offset, int limit);
  Future<List<Episode>> getFromSubscriptionsPaginated(int offset, int limit);
}

abstract class SubscriptionStore {
  Future<void> subscribe(String podcastId);
  Future<void> unsubscribe(String podcastId);
  Future<SubscriptionsScreenData> getScreenData();
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
  Future<void> push(Task task);
  Future<void> pop();
  Stream<Task> watchFront();
}
