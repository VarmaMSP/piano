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
    return PreferenceValue.fromJson(
      json.decode(fromDb) as Map<String, dynamic>,
    );
  }

  @override
  String mapToSql(PreferenceValue value) {
    return json.encode(value.toJson());
  }
}

PreferenceRow preferenceRowFromModel(Preference model) {
  return PreferenceRow(
    key: model.key,
    value: model.value,
  );
}

extension PreferenceRowExtension on PreferenceRow {
  Preference toModel() {
    return Preference(
      key: key,
      value: value,
    );
  }
}
