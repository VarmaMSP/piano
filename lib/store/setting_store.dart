// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/model/preference.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/service/db/db.dart';
import 'package:phenopod/utils/file.dart' as fileutils;

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
  Stream<StorageSetting> watchStorageSetting() async* {
    final settingStream = db.preferenceDao
        .watchPreferenceByKey(_audioPlayerSettingKey)
        .map((x) => x?.value);

    var setting = await settingStream.first;
    if (setting == null) {
      // Assign defaults
      setting = StorageSetting(
        storage: Storage.internalStorage,
        storagePath: await fileutils.getInternalStorageDirectory(),
      );
      await saveStorageSetting(setting);
    }

    yield* settingStream.distinct();
  }

  @override
  Stream<AudioPlayerSetting> watchAudioPlayerSetting() async* {
    final settingStream = db.preferenceDao
        .watchPreferenceByKey(_storageSettingKey)
        .map((x) => x?.value);

    var setting = await settingStream.first;
    if (setting = null) {
      // Assign defaults
      setting = AudioPlayerSetting(
        seekBackwardTime: 30,
        seekForwardTime: 30,
      );
      await saveAudioPlayerSetting(setting);
    }

    yield* settingStream.distinct();
  }
}
