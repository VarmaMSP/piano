// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CachePodcast _$_$_CachePodcastFromJson(Map<String, dynamic> json) {
  return _$_CachePodcast(
    podcastId: json['podcastId'] as String,
    podcastUrlParam: json['podcastUrlParam'] as String,
  );
}

Map<String, dynamic> _$_$_CachePodcastToJson(_$_CachePodcast instance) =>
    <String, dynamic>{
      'podcastId': instance.podcastId,
      'podcastUrlParam': instance.podcastUrlParam,
    };

_$_DownloadEpisode _$_$_DownloadEpisodeFromJson(Map<String, dynamic> json) {
  return _$_DownloadEpisode(
    episodeId: json['episodeId'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
    storagePath: json['storagePath'] as String,
  );
}

Map<String, dynamic> _$_$_DownloadEpisodeToJson(_$_DownloadEpisode instance) =>
    <String, dynamic>{
      'episodeId': instance.episodeId,
      'url': instance.url,
      'filename': instance.filename,
      'storagePath': instance.storagePath,
    };
