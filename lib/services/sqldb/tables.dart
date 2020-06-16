import 'package:moor/moor.dart';

@DataClassName('PodcastRow')
class Podcasts extends Table {
  TextColumn get id => text()();
  TextColumn get urlParam => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get language => text()();
  IntColumn get explicit => integer()();
  TextColumn get author => text()();
  TextColumn get type => text()();
  IntColumn get complete => integer()();
  TextColumn get link => text()();
  TextColumn get copyright => text()();
  IntColumn get totalEpisodes => integer()();
  IntColumn get totalSeasons => integer()();
  TextColumn get feedUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('EpisodeRow')
class Episodes extends Table {
  TextColumn get id => text()();
  TextColumn get podcastId =>
      text().customConstraint('REFERENCES podcasts(id)')();
  TextColumn get urlParam => text()();
  TextColumn get title => text()();
  TextColumn get mediaUrl => text()();
  TextColumn get pubDate => text()();
  TextColumn get summary => text()();
  TextColumn get description => text()();
  IntColumn get duration => integer()();
  IntColumn get explicit => integer()();
  IntColumn get episode => integer()();
  IntColumn get season => integer()();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// This table stores items that are in the queue and item that is playing.
/// Position of audioTracks start from 1 and item at position 0 represent
/// the currently playing episode
@DataClassName('AudioTrackRow')
class AudioTracks extends Table {
  IntColumn get position => integer()();
  TextColumn get episodeId =>
      text().customConstraint('REFERENCES episodes(id)')();

  @override
  Set<Column> get primaryKey => {position};
}
