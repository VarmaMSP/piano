part of 'main.dart';

class EpisodePlaceholder extends Equatable {
  final String title;
  final String podcastTitle;
  final String podcastUrlparam;

  EpisodePlaceholder({
    this.title,
    this.podcastTitle,
    this.podcastUrlparam,
  });

  @override
  List<Object> get props => [title];
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class Episode extends Equatable {
  final String id;
  final String urlParam;
  final String title;
  final String mediaUrl;

  @JsonKey(defaultValue: '')
  final String podcastId;

  @JsonKey(fromJson: parseDateTime)
  final DateTime pubDate;

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
    @required this.id,
    @required this.urlParam,
    @required this.title,
    @required this.mediaUrl,
    @required this.podcastId,
    @required this.pubDate,
    @required this.summary,
    @required this.description,
    @required this.duration,
    @required this.explicit,
    @required this.episode,
    @required this.season,
    @required this.type,
    @required this.titleHighlighted,
    @required this.descriptionHighlighted,
    @required this.progress,
    @required this.lastPlayedAt,
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
  String toString() => 'Episode: { title: $title }';
}

class EpisodeMeta extends Equatable {
  final DownloadProgress downloadProgress;
  final AudioTrack audioTrack;

  EpisodeMeta({
    @required this.downloadProgress,
    @required this.audioTrack,
  });

  @override
  List<Object> get props => [audioTrack, downloadProgress];
}
