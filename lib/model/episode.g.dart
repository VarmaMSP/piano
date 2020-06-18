// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, cast_to_non_type, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'episode.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EpisodeCopyWithExtension on Episode {
  Episode copyWith({
    String description,
    String descriptionHighlighted,
    int duration,
    int episode,
    int explicit,
    String id,
    String lastPlayedAt,
    String mediaUrl,
    String podcastId,
    double progress,
    String pubDate,
    int season,
    String summary,
    String title,
    String titleHighlighted,
    String type,
    String urlParam,
  }) {
    return Episode(
      description: description ?? this.description,
      descriptionHighlighted:
          descriptionHighlighted ?? this.descriptionHighlighted,
      duration: duration ?? this.duration,
      episode: episode ?? this.episode,
      explicit: explicit ?? this.explicit,
      id: id ?? this.id,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      podcastId: podcastId ?? this.podcastId,
      progress: progress ?? this.progress,
      pubDate: pubDate ?? this.pubDate,
      season: season ?? this.season,
      summary: summary ?? this.summary,
      title: title ?? this.title,
      titleHighlighted: titleHighlighted ?? this.titleHighlighted,
      type: type ?? this.type,
      urlParam: urlParam ?? this.urlParam,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    title: json['title'] as String,
    mediaUrl: json['media_url'] as String,
    podcastId: json['podcast_id'] as String ?? '',
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
    progress: (json['progress'] as num)?.toDouble() ?? 0.0,
    lastPlayedAt: json['last_played_at'] as String ?? '',
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'title': instance.title,
      'media_url': instance.mediaUrl,
      'podcast_id': instance.podcastId,
      'pub_date': instance.pubDate,
      'summary': instance.summary,
      'description': instance.description,
      'duration': instance.duration,
      'explicit': instance.explicit,
      'episode': instance.episode,
      'season': instance.season,
      'type': instance.type,
      'title_highlighted': instance.titleHighlighted,
      'description_highlighted': instance.descriptionHighlighted,
      'progress': instance.progress,
      'last_played_at': instance.lastPlayedAt,
    };
