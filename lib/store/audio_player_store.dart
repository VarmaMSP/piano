// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';

AudioPlayerStore newAudioPlayerStore(
  Api api,
  Db db, [
  AlarmService alarmService,
  bool lazyQueries,
]) {
  return _AudioPlayerStoreImpl(
    api: api,
    db: db,
    alarmService: alarmService,
    lazyQueries: lazyQueries,
  );
}

abstract class AudioPlayerStore {
  Future<void> saveQueue(Queue queue);
  Queue getQueue();
  Stream<Queue> watchQueue();
}

class _AudioPlayerStoreImpl extends AudioPlayerStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;
  final bool lazyQueries;

  final String _queueDetailsKey = 'QUEUE_DETAILS';

  /// Keep queue in memory
  final BehaviorSubject<Queue> _queue =
      BehaviorSubject<Queue>.seeded(Queue.empty());

  _AudioPlayerStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
    @required this.lazyQueries,
  }) {
    if (lazyQueries) {
      _watchQueue().listen(_queue.add);
    }
  }

  @override
  Future<void> saveQueue(Queue queue) async {
    final podcasts = queue.audioTracks.map((x) => x.podcast).toList();
    final episodes = queue.audioTracks.map((x) => x.episode).toList();
    await db.transaction(() async {
      await db.audioTrackDao.deleteAllTracks();
      await db.podcastDao.savePodcasts(podcasts);
      await db.episodeDao.saveEpisodes(episodes);
      await db.audioTrackDao.saveTracks(queue.audioTracks);
      await db.preferenceDao.savePreference(
        Preference(
          key: _queueDetailsKey,
          value: QueueDetails(position: queue.position),
        ),
      );
    });
  }

  @override
  Queue getQueue() {
    if (lazyQueries) {
      return _queue.value;
    }
    throw ('Lazy Queries not enabled');
  }

  @override
  Stream<Queue> watchQueue() {
    return lazyQueries ? _queue.stream : _watchQueue();
  }

  Stream<Queue> _watchQueue() {
    return Rx.combineLatest2<QueueDetails, List<AudioTrack>, Queue>(
      db.preferenceDao
          .watchPreferenceByKey(_queueDetailsKey)
          .where((pref) => pref != null)
          .map((pref) => pref?.value),
      db.audioTrackDao.watchAllTracks(),
      (details, tracks) {
        return details.position < 0 || details.position >= tracks.length
            ? Queue.empty()
            : Queue(audioTracks: tracks, position: details.position);
      },
    );
  }
}
