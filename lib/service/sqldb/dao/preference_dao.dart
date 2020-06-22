part of '../sqldb.dart';

@UseDao(tables: [Preferences])
class PreferenceDao extends DatabaseAccessor<SqlDb> with _$PreferenceDaoMixin {
  PreferenceDao(SqlDb db) : super(db);
}
