part of '../db.dart';

@UseDao(tables: [Preferences])
class PreferenceDao extends DatabaseAccessor<SqlDb> with _$PreferenceDaoMixin {
  PreferenceDao(SqlDb db) : super(db);

  Future<void> savePreference({String key, PreferenceValue value}) async {
    await into(preferences).insert(
      PreferenceRow(key: key, value: value),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<PreferenceValue> watchPreference(String key) {
    return (select(preferences)..where((tbl) => tbl.key.equals(key)))
        .watchSingle()
        .map((x) => x?.value);
  }

  Future<PreferenceValue> getPreference(String key) async {
    final row = await (select(preferences)..where((tbl) => tbl.key.equals(key)))
        .getSingle();
    return row?.value;
  }
}
