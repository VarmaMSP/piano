part of '../db.dart';

@DataClassName('PreferenceRow')
class Preferences extends Table {
  TextColumn get key => text()();
  TextColumn get value =>
      text().map(PreferenceValueTypeConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PreferenceValue {
  final QueuePreference queuePreference;
  final AudioPlayerSetting audioPlayerSetting;

  const PreferenceValue({this.queuePreference, this.audioPlayerSetting});

  factory PreferenceValue.fromJson(Map<String, dynamic> json) {
    return _$PreferenceValueFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferenceValueToJson(this);
  }
}

class PreferenceValueTypeConverter
    extends TypeConverter<PreferenceValue, String> {
  const PreferenceValueTypeConverter();

  @override
  PreferenceValue mapToDart(String fromDb) {
    return fromDb != null
        ? PreferenceValue.fromJson(json.decode(fromDb) as Map<String, dynamic>)
        : PreferenceValue(
            queuePreference: Queue.empty().preference,
            audioPlayerSetting: AudioPlayerSetting.standard(),
          );
  }

  @override
  String mapToSql(PreferenceValue value) {
    return value != null ? json.encode(value.toJson()) : null;
  }
}
