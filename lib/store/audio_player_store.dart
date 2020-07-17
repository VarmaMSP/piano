import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:rxdart/rxdart.dart';

AudioPlayerStore newAudioPlayerStore(Api api, Db db) {
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
  final Db db;

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
          key: QueueDetails.key,
          value: PreferenceValue(queueDetails: QueueDetails.fromQueue(queue)),
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
        key: QueueDetails.key,
        value: PreferenceValue(queueDetails: QueueDetails.fromQueue(queue)),
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
    return Rx.combineLatest2<QueueDetails, List<AudioTrack>, Queue>(
      db.preferenceDao
          .watchPreference(QueueDetails.key)
          .map((value) => value?.queueDetails),
      db.audioTrackDao.watchAllTracks(),
      (details, tracks) {
        // Return default if you cannot find details
        if (details == null) {
          return Queue.empty();
        }
        // If this is the case something is seriously wrong with the queue logic
        if (details.position < 0 || details.position >= tracks.length) {
          return Queue.empty();
        }

        return Queue(audioTracks: tracks, position: details.position);
      },
    );
  }

  @override
  Stream<AudioTrack> watchNowPlaying() {
    return db.preferenceDao.watchPreference(QueueDetails.key).asyncMap(
      (pref) {
        final details = pref?.queueDetails;
        return details != null
            ? db.audioTrackDao.getTrackByPosition(details.position)
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
