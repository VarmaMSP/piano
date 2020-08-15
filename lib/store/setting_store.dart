// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:when_expression/when_expression.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';
import 'package:phenopod/utils/file.dart' as fileutils;

SettingStore newSettingStore(
  Api api,
  Db db,
  AlarmService alarmService,
  bool lazyQueries,
) {
  return _SettingStoreImpl(api: api, db: db, alarmService: alarmService);
}

abstract class SettingStore {
  Future<void> saveStorageSetting(StorageSetting storageSetting);
  Future<void> saveAudioPlayerSetting(AudioPlayerSetting audioPlayerSetting);
  Stream<StorageSetting> watchStorageSetting();
  Stream<AudioPlayerSetting> watchAudioPlayerSetting();
}

class _SettingStoreImpl extends SettingStore {
  final Api api;
  final Db db;
  final AlarmService alarmService;

  final String _storageSettingKey = 'STORAGE_SETTING';
  final String _audioPlayerSettingKey = 'AUDIO_PLAYER_SETTING';

  _SettingStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
  });

  @override
  Future<void> saveStorageSetting(StorageSetting storageSetting) async {
    await db.preferenceDao.savePreference(
      Preference(
        key: _storageSettingKey,
        value: storageSetting,
      ),
    );
  }

  @override
  Future<void> saveAudioPlayerSetting(
    AudioPlayerSetting audioPlayerSetting,
  ) async {
    await db.preferenceDao.savePreference(
      Preference(
        key: _audioPlayerSettingKey,
        value: audioPlayerSetting,
      ),
    );
  }

  @override
  Stream<StorageSetting> watchStorageSetting() {
    return db.preferenceDao
        .watchPreferenceByKey(_storageSettingKey)
        .map((x) => x?.value as StorageSetting)
        .asyncMap(when<StorageSetting, FutureOr<StorageSetting>>({
          (s) => s != null: (s) => s,
          (_) => true: (_) async {
            final setting = StorageSetting(
              storage: Storage.internalStorage,
              storagePath: await fileutils.getInternalStorageDirectory(),
            );
            await saveStorageSetting(setting);
            return setting;
          }
        }))
        .distinct();
  }

  @override
  Stream<AudioPlayerSetting> watchAudioPlayerSetting() {
    return db.preferenceDao
        .watchPreferenceByKey(_audioPlayerSettingKey)
        .map((x) => x?.value as AudioPlayerSetting)
        .asyncMap(when<AudioPlayerSetting, FutureOr<AudioPlayerSetting>>({
          (s) => s != null: (s) => s,
          (_) => true: (_) async {
            final setting = AudioPlayerSetting(
              seekBackwardTime: 30,
              seekForwardTime: 30,
            );
            await saveAudioPlayerSetting(setting);
            return setting;
          }
        }))
        .distinct();
  }
}
