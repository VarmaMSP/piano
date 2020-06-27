import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/model/setting.dart';
import 'package:phenopod/store/store.dart';

class PreferenceDb extends PreferenceStore {
  final PreferenceStore baseStore;
  PreferenceDao _preferenceDao;

  PreferenceDb({this.baseStore, SqlDb sqldb}) {
    _preferenceDao = PreferenceDao(sqldb);
  }

  @override
  Future<void> saveAudioSetting(AudioPlayerSetting setting) {
    return _preferenceDao.savePreference(
      key: AudioPlayerSetting.key,
      value: PreferenceValue(audioPlayerSetting: setting),
    );
  }

  @override
  Future<AudioPlayerSetting> getAudioSetting() async {
    final value = await _preferenceDao.getPreference(AudioPlayerSetting.key);
    return value?.audioPlayerSetting ?? AudioPlayerSetting.standard();
  }

  @override
  Stream<AudioPlayerSetting> watchAudioSetting() {
    return _preferenceDao
        .watchPreference(AudioPlayerSetting.key)
        .map((x) => x?.audioPlayerSetting ?? AudioPlayerSetting.standard());
  }
}
