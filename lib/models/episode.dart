import 'package:equatable/equatable.dart';

class Episode extends Equatable {
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
    return Episode(
      id: json['id'] as String,
      urlParam: json['url_param'] as String,
      title: json['title'] as String,
      mediaUrl: json['media_url'] as String,
      pubDate: json['pub_date'] as String ?? '',
      summary: json['summary'] as String ?? '',
      description: json['description'] as String ?? '',
      duration: json['duration'] as int ?? 0,
      explicit: json['explicit'] as int ?? 0,
      episode: json['episode'] as int ?? 0,
      season: json['season'] as int ?? 0,
      type: json['type'] as String ?? '',
      titleHighlighted: json['title_highlighted'] as String ?? '',
      descriptionHighlighted: json['description_highlighted'] as String ?? '',
      progress: (json['progress'] as double ?? 0.0) + 0.0,
      lastPlayedAt: json['last_played_at'] as String ?? '',
    );
  }

  final String id;
  final String urlParam;
  final String title;
  final String mediaUrl;
  final String pubDate;
  final String summary;
  final String description;
  final int duration;
  final int explicit;
  final int episode;
  final int season;
  final String type;
  final String titleHighlighted;
  final String descriptionHighlighted;
  final double progress;
  final String lastPlayedAt;

  Episode copyWith({
    String id,
    String urlParam,
    String title,
    String mediaUrl,
    String pubDate,
    String summary,
    String description,
    int duration,
    int explicit,
    int episode,
    int season,
    String type,
    String titleHighlighted,
    String descriptionHighlighted,
    double progress,
    String lastPlayedAt,
  }) {
    return Episode(
      id: id ?? this.id,
      urlParam: urlParam ?? this.urlParam,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      pubDate: pubDate ?? this.pubDate,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      explicit: explicit ?? this.explicit,
      episode: episode ?? this.episode,
      season: season ?? this.season,
      type: type ?? this.type,
      titleHighlighted: titleHighlighted ?? this.titleHighlighted,
      descriptionHighlighted:
          descriptionHighlighted ?? this.descriptionHighlighted,
      progress: progress ?? this.progress,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'url_param': urlParam,
      'title': title,
      'media_url': mediaUrl,
      'pub_date': pubDate,
      'summary': summary,
      'description': description,
      'duration': duration,
      'explicit': explicit,
      'episode': episode,
      'season': season,
      'type': type,
      'title_highlighted': titleHighlighted,
      'description_highlighted': descriptionHighlighted,
      'progress': progress,
      'lastPlayedAt': lastPlayedAt,
    };
  }

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Episode: { id: $id }';
}
