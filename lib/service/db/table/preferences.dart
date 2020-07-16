part of '../db.dart';

@DataClassName('PreferenceRow')
class Preferences extends Table {
  TextColumn get key => text()();
  TextColumn get value =>
      text().map(PreferenceValueTypeConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

class PreferenceValueTypeConverter
    extends TypeConverter<PreferenceValue, String> {
  const PreferenceValueTypeConverter();

  @override
  PreferenceValue mapToDart(String fromDb) {
    return fromDb != null
        ? PreferenceValue.fromJson(json.decode(fromDb) as Map<String, dynamic>)
        : PreferenceValue.fromNull();
  }

  @override
  String mapToSql(PreferenceValue value) {
    return value != null ? json.encode(value.toJson()) : null;
  }
}
