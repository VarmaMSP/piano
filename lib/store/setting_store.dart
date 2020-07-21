// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/preference.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';

SettingStore newSettingStore(Api api, Db db) {
  return _SettingStoreImpl(api: api, db: db);
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

  final String _storageSettingKey = 'STORAGE_SETTING';
  final String _audioPlayerSettingKey = 'AUDIO_PLAYER_SETTING';

  // Default Settings
  final StorageSetting defaultStorageSetting = StorageSetting(
    storage: Storage.none,
    storagePath: '',
  );
  final AudioPlayerSetting defaultAudioPlayerSetting = AudioPlayerSetting(
    seekBackwardTime: 30,
    seekForwardTime: 30,
  );

  _SettingStoreImpl({
    @required this.api,
    @required this.db,
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
        .watchPreferenceByKey(_audioPlayerSettingKey)
        .map((x) => x?.value ?? defaultStorageSetting);
  }

  @override
  Stream<AudioPlayerSetting> watchAudioPlayerSetting() {
    return db.preferenceDao
        .watchPreferenceByKey(_storageSettingKey)
        .map((x) => x?.value ?? defaultAudioPlayerSetting);
  }
}
