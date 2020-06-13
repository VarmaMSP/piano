import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'episode.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class Episode extends Equatable {
  final String id;
  final String urlParam;
  final String title;
  final String mediaUrl;

  @JsonKey(defaultValue: '')
  final String pubDate;

  @JsonKey(defaultValue: '')
  final String summary;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: 0)
  final int duration;

  @JsonKey(defaultValue: 0)
  final int explicit;

  @JsonKey(defaultValue: 0)
  final int episode;

  @JsonKey(defaultValue: 0)
  final int season;

  @JsonKey(defaultValue: '')
  final String type;

  @JsonKey(defaultValue: '')
  final String titleHighlighted;

  @JsonKey(defaultValue: '')
  final String descriptionHighlighted;

  @JsonKey(defaultValue: 0.0)
  final double progress;

  @JsonKey(defaultValue: '')
  final String lastPlayedAt;

  const Episode({
    this.id,
    this.urlParam,
    this.title,
    this.mediaUrl,
    this.pubDate,
    this.summary,
    this.description,
    this.duration,
    this.explicit,
    this.episode,
    this.season,
    this.type,
    this.titleHighlighted,
    this.descriptionHighlighted,
    this.progress,
    this.lastPlayedAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return _$EpisodeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EpisodeToJson(this);
  }

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Episode: { id: $id }';
}
