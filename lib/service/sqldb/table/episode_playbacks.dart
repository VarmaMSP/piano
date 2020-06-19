part of '../sqldb.dart';

@DataClassName('EpisodePlaybackRow')
class EpisodePlaybacks extends Table {
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();
}
