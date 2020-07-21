import 'package:flutter/foundation.dart';
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

  _SettingStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> saveStorageSetting(StorageSetting storageSetting) async {
    await db.preferenceDao.savePreference(
      key: StorageSetting.key,
      value: PreferenceValue(storageSetting: storageSetting),
    );
  }

  @override
  Future<void> saveAudioPlayerSetting(
    AudioPlayerSetting audioPlayerSetting,
  ) async {
    await db.preferenceDao.savePreference(
      key: AudioPlayerSetting.key,
      value: PreferenceValue(audioPlayerSetting: audioPlayerSetting),
    );
  }

  @override
  Stream<AudioPlayerSetting> watchAudioPlayerSetting() {
    return db.preferenceDao
        .watchPreference(AudioPlayerSetting.key)
        .map((x) => x?.audioPlayerSetting ?? AudioPlayerSetting.standard());
  }

  @override
  Stream<StorageSetting> watchStorageSetting() {
    return db.preferenceDao
        .watchPreference(StorageSetting.key)
        .map((x) => x?.storageSetting ?? StorageSetting.standard());
  }
}
