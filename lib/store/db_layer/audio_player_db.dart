import 'package:phenopod/model/main.dart';
import 'package:phenopod/model/queue.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

import 'db.dart';

class AudioPlayerDb extends AudioPlayerStore {
  final Db db;
  final AudioPlayerStore baseStore;

  AudioPlayerDb({this.baseStore, this.db});

  @override
  Future<void> saveQueue(Queue queue) async {
    if (queue.isEmpty) {
      await db.transaction(() async {
        await db.audioTrackDao.deleteAllTracks();
        await db.preferenceDao.savePreference(
          key: QueuePreference.key,
          value: PreferenceValue(queuePreference: queue.preference),
        );
      });
      return;
    }

    final podcasts = queue.audioTracks.map((x) => x.podcast).toList();
    final episodes = queue.audioTracks.map((x) => x.episode).toList();
    await db.transaction(() async {
      await db.podcastDao.savePodcasts(podcasts);
      await db.episodeDao.saveEpisodes(episodes);
      await db.audioTrackDao.saveTracks(queue.audioTracks);
      await db.audioTrackDao.deleteTracksNotInQueue(queue.audioTracks.length);
      await db.preferenceDao.savePreference(
        key: QueuePreference.key,
        value: PreferenceValue(queuePreference: queue.preference),
      );
    });
  }

  @override
  Future<void> saveSetting(AudioPlayerSetting setting) {
    return db.preferenceDao.savePreference(
      key: AudioPlayerSetting.key,
      value: PreferenceValue(audioPlayerSetting: setting),
    );
  }

  @override
  Stream<Queue> watchQueue() {
    return Rx.combineLatest2<QueuePreference, List<AudioTrack>, Queue>(
      db.preferenceDao
          .watchPreference(QueuePreference.key)
          .map((value) => value?.queuePreference),
      db.audioTrackDao.watchAllTracks(),
      (prefs, tracks) =>
          prefs == null || prefs.position < 0 || prefs.position >= tracks.length
              ? Queue.empty()
              : Queue(audioTracks: tracks, position: prefs.position),
    );
  }

  @override
  Future<Queue> getQueue() {
    return watchQueue().first;
  }

  @override
  Future<AudioTrack> getNowPlaying() async {
    final pref = (await db.preferenceDao.getPreference(QueuePreference.key))
        ?.queuePreference;
    return pref == null
        ? null
        : await db.audioTrackDao.getTrackByPosition(pref.position);
  }

  @override
  Stream<AudioPlayerSetting> watchSetting() {
    return db.preferenceDao
        .watchPreference(AudioPlayerSetting.key)
        .map((x) => x?.audioPlayerSetting ?? AudioPlayerSetting.standard());
  }

  @override
  Future<AudioPlayerSetting> getSetting() {
    return watchSetting().first;
  }
}
