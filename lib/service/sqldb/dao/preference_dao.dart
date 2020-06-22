part of '../sqldb.dart';

@UseDao(tables: [Preferences])
class PreferenceDao extends DatabaseAccessor<SqlDb> with _$PodcastDaoMixin {
  PreferenceDao(SqlDb db) : super(db);
}
