import 'package:phenopod/model/main.dart';

abstract class Store {
  UserStore get user;
  PodcastStore get podcast;
  EpisodeStore get episode;
  SubscriptionStore get subscription;
  QueueStore get queue;
  PlaybackPositionStore get playbackPosition;
  PreferenceStore get preference;
}

abstract class UserStore {
  Future<User> getSignedInUser();
  Future<void> signInWithGuest();
}

abstract class PodcastStore {
  Future<void> saveScreeData(String podcastUrlParam);
  Future<PodcastScreenData> getScreenData(String podcastUrlParam);
  Stream<PodcastScreenData> watchScreenData(String podcastUrlParam);
  Future<void> deleteScreenData(String podcastUrlParam);
}

abstract class EpisodeStore {
  Future<List<Episode>> getByPodcastPaginated(
    String podcastId,
    int offset,
    int limit,
  );
  Future<List<Episode>> getFromSubscriptionsPaginated(int offset, int limit);
}

abstract class SubscriptionStore {
  Future<void> subscribe(String podcastId);
  Future<void> unsubscribe(String podcastId);
  Future<SubscriptionsScreenData> getScreenData();
}

abstract class QueueStore {
  Future<void> save(Queue queue);
  Future<Queue> get_();
  Stream<Queue> watch();
  Future<AudioTrack> getNowPlaying();
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
