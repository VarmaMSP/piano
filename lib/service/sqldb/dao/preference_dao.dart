part of '../sqldb.dart';

@UseDao(tables: [Preferences])
class PreferenceDao extends DatabaseAccessor<SqlDb> with _$PreferenceDaoMixin {
  PreferenceDao(SqlDb db) : super(db);

  Future<void> saveValue({String key, PreferenceValue value}) async {
    await into(preferences).insert(
      PreferenceRow(key: key, value: value),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<PreferenceValue> watchValue(String key) {
    return (select(preferences)..where((tbl) => tbl.key.equals(key)))
        .watchSingle()
        .map((x) => x?.value);
  }

  Future<PreferenceValue> getValue(String key) {
    return watchValue(key).first;
  }
}
