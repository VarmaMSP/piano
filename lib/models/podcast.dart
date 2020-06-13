import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

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
  final bool complete;

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

  const Podcast({
    this.id,
    this.urlParam,
    this.title,
    this.summary,
    this.description,
    this.language,
    this.explicit,
    this.author,
    this.type,
    this.complete,
    this.link,
    this.copyright,
    this.totalEpisodes,
    this.totalSeasons,
    this.earliestEpisodePubDate,
    this.titleHighlighted,
    this.authorHighlighted,
    this.descriptionHiglighted,
    this.feedUrl,
    this.feedLastRefreshAt,
    this.isSubscribed,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return _$PodcastFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PodcastToJson(this);
  }

  @override
  List<Object> get props => [id, isSubscribed];

  @override
  String toString() => 'Podcast: { id: $id }';
}
