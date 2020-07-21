// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

AudioPlayerStore newAudioPlayerStore(Api api, Db db) {
  return _AudioPlayerStoreImpl(api: api, db: db);
}

abstract class AudioPlayerStore {
  Future<void> saveQueue(Queue queue);
  Stream<Queue> watchQueue();
  Stream<AudioTrack> watchNowPlaying();
}

class _AudioPlayerStoreImpl extends AudioPlayerStore {
  final Api api;
  final Db db;

  final String _queueDetailsKey = 'QUEUE_DETAILS';

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
          Preference(
            key: _queueDetailsKey,
            value: QueueDetails(position: queue.position),
          ),
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
        Preference(
          key: _queueDetailsKey,
          value: QueueDetails(position: queue.position),
        ),
      );
    });
  }

  @override
  Stream<Queue> watchQueue() {
    return Rx.combineLatest2<QueueDetails, List<AudioTrack>, Queue>(
      db.preferenceDao
          .watchPreferenceByKey(_queueDetailsKey)
          .map((value) => value?.value),
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
    return db.preferenceDao.watchPreferenceByKey(_queueDetailsKey).asyncMap(
      (pref) {
        final details = pref?.value as QueueDetails;
        return details == null
            ? null
            : db.audioTrackDao.getTrackByPosition(details.position);
      },
    );
  }
}
