import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:rxdart/rxdart.dart';

AudioPlayerStore newAudioPlayerStore(Api api, Db_ db) {
  return _AudioPlayerStoreImpl(api: api, db: db);
}

abstract class AudioPlayerStore {
  Future<void> saveQueue(Queue queue);
  Future<void> saveSetting(AudioPlayerSetting setting);
  Stream<Queue> watchQueue();
  Stream<AudioTrack> watchNowPlaying();
  Stream<AudioPlayerSetting> watchSetting();
}

class _AudioPlayerStoreImpl extends AudioPlayerStore {
  final Api api;
  final Db_ db;

  _AudioPlayerStoreImpl({
    @required this.api,
    @required this.db,
  });

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
  Future<void> saveSetting(AudioPlayerSetting setting) async {
    await db.preferenceDao.savePreference(
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
  Stream<AudioTrack> watchNowPlaying() {
    return db.preferenceDao.watchPreference(QueuePreference.key).asyncMap(
      (pref) {
        final queuePref = pref?.queuePreference;
        return queuePref != null
            ? db.audioTrackDao.getTrackByPosition(queuePref.position)
            : Future.value(null);
      },
    );
  }

  @override
  Stream<AudioPlayerSetting> watchSetting() {
    return db.preferenceDao
        .watchPreference(AudioPlayerSetting.key)
        .map((x) => x?.audioPlayerSetting ?? AudioPlayerSetting.standard());
  }
}
