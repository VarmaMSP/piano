part of '../db.dart';

@UseDao(tables: [Preferences])
class PreferenceDao extends DatabaseAccessor<SqlDb> with _$PreferenceDaoMixin {
  PreferenceDao(SqlDb db) : super(db);

  Future<void> savePreference(Preference preference) async {
    await into(preferences).insert(
      preferenceRowFromModel(preference),
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<Preference> watchPreferenceByKey(String key) {
    return (select(preferences)..where((tbl) => tbl.key.equals(key)))
        .watchSingle()
        .map((x) => x?.toModel());
  }

  Future<void> deletePreference(String key) async {
    await (delete(preferences)..where((tbl) => tbl.key.equals(key))).go();
  }
}
