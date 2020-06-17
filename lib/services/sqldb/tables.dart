part of 'sqldb.dart';

@DataClassName('PodcastRow')
class Podcasts extends Table {
  TextColumn get id => text()();
  TextColumn get urlParam => text().customConstraint('UNIQUE')();
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

PodcastRow podcastRowFromModel(Podcast model) {
  return PodcastRow(
    id: model.id,
    urlParam: model.urlParam,
    title: model.title,
    description: model.description,
    language: model.language,
    explicit: model.explicit,
    author: model.author,
    type: model.type,
    complete: model.complete,
    link: model.link,
    copyright: model.copyright,
    totalEpisodes: model.totalEpisodes,
    totalSeasons: model.totalSeasons,
    feedUrl: model.feedUrl,
  );
}

extension PodcastRowExtension on PodcastRow {
  Podcast toModel() {
    return Podcast(
      id: id,
      urlParam: urlParam,
      title: title,
      summary: '',
      description: description,
      language: language,
      explicit: explicit,
      author: author,
      type: type,
      complete: complete,
      link: link,
      copyright: copyright,
      totalEpisodes: totalEpisodes,
      totalSeasons: totalSeasons,
      earliestEpisodePubDate: '',
      titleHighlighted: '',
      authorHighlighted: '',
      descriptionHiglighted: '',
      feedUrl: feedUrl,
      feedLastRefreshAt: '',
      isSubscribed: false,
    );
  }
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
