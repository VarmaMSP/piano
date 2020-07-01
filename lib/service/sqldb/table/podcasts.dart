part of '../sqldb.dart';

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
  BoolColumn get isCached => boolean()();
  DateTimeColumn get cachedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
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
    isCached: model.isCached,
    cachedAt: model.cachedAt,
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
      isCached: isCached,
      cachedAt: cachedAt,
    );
  }
}
