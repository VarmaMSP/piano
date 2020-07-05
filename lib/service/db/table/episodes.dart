part of '../db.dart';

@DataClassName('EpisodeRow')
class Episodes extends Table {
  TextColumn get id => text()();
  TextColumn get podcastId =>
      text().customConstraint('REFERENCES podcasts(id)')();
  TextColumn get urlParam => text().customConstraint('UNIQUE')();
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

EpisodeRow episodeRowFromModel(Episode model) {
  return EpisodeRow(
    id: model.id,
    podcastId: model.podcastId,
    urlParam: model.urlParam,
    title: model.title,
    mediaUrl: model.mediaUrl,
    pubDate: model.pubDate,
    summary: model.summary,
    description: model.description,
    duration: model.duration,
    explicit: model.explicit,
    episode: model.episode,
    season: model.season,
    type: model.type,
  );
}

extension EpisodeRowExtension on EpisodeRow {
  Episode toModel() {
    return Episode(
      id: id,
      urlParam: urlParam,
      title: title,
      mediaUrl: mediaUrl,
      podcastId: podcastId,
      pubDate: pubDate,
      summary: summary,
      description: description,
      duration: duration,
      explicit: explicit,
      episode: episode,
      season: season,
      type: type,
      titleHighlighted: '',
      descriptionHighlighted: '',
      progress: 0.0,
      lastPlayedAt: '',
    );
  }
}
