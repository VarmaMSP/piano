import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'category.dart';
import 'episode.dart';

part 'podcast.g.dart';

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

  // * This field is derived when it comes to db while
  // * it is received as it in case from the api
  @JsonKey(defaultValue: false)
  final bool isSubscribed;

  @JsonKey(ignore: true)
  final List<Episode> episodes;

  @JsonKey(ignore: true)
  final List<Category> categories;

  //* Fields derived from db
  @JsonKey(ignore: true)
  final bool isCached;

  @JsonKey(ignore: true)
  final DateTime cachedAt;

  //* Fields derived from api response
  @JsonKey(ignore: true)
  final bool moreEpisodes;

  const Podcast({
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
    this.episodes = const <Episode>[],
    this.categories = const <Category>[],
    this.isCached = false,
    this.cachedAt,
    this.moreEpisodes = false,
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
