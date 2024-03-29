part of 'main.dart';

class PodcastPlaceholder extends Equatable {
  final String title;
  final String author;
  final bool isSubscribed;

  PodcastPlaceholder({
    @required this.title,
    @required this.author,
    @required this.isSubscribed,
  });

  @override
  List<Object> get props => [title, isSubscribed];
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class Podcast extends Equatable {
  final String id;
  final String urlParam;
  final String title;

  @JsonKey(defaultValue: '')
  final String summary;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String language;

  @JsonKey(defaultValue: 0)
  final int explicit;

  @JsonKey(defaultValue: '')
  final String author;

  @JsonKey(defaultValue: '')
  final String type;

  @JsonKey(defaultValue: 0)
  final int complete;

  @JsonKey(defaultValue: '')
  final String link;

  @JsonKey(defaultValue: '')
  final String copyright;

  @JsonKey(defaultValue: 0)
  final int totalEpisodes;

  @JsonKey(defaultValue: 0)
  final int totalSeasons;

  @JsonKey(defaultValue: '')
  final String earliestEpisodePubDate;

  @JsonKey(defaultValue: '')
  final String titleHighlighted;

  @JsonKey(defaultValue: '')
  final String authorHighlighted;

  @JsonKey(defaultValue: '')
  final String descriptionHiglighted;

  @JsonKey(defaultValue: '')
  final String feedUrl;

  @JsonKey(defaultValue: '')
  final String feedLastRefreshAt;

  @JsonKey(defaultValue: false)
  final bool isSubscribed;

  // If true, all episodes have been stored in the db
  @JsonKey(ignore: true)
  final bool cachedAllEpisodes;

  // Last time at which podcast is updated in db
  @JsonKey(ignore: true)
  final DateTime cacheUpdatedAt;

  Podcast({
    @required this.id,
    @required this.urlParam,
    @required this.title,
    @required this.summary,
    @required this.description,
    @required this.language,
    @required this.explicit,
    @required this.author,
    @required this.type,
    @required this.complete,
    @required this.link,
    @required this.copyright,
    @required this.totalEpisodes,
    @required this.totalSeasons,
    @required this.earliestEpisodePubDate,
    @required this.titleHighlighted,
    @required this.authorHighlighted,
    @required this.descriptionHiglighted,
    @required this.feedUrl,
    @required this.feedLastRefreshAt,
    @required this.isSubscribed,
    this.cachedAllEpisodes,
    this.cacheUpdatedAt,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return _$PodcastFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PodcastToJson(this);
  }

  @override
  List<Object> get props => [id, urlParam, isSubscribed];

  @override
  String toString() => 'Podcast: { title: $title }';
}
