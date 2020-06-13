// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension QueueItemCopyWithExtension on QueueItem {
  QueueItem copyWith({
    Episode episode,
    Podcast podcast,
  }) {
    return QueueItem(
      episode: episode ?? this.episode,
      podcast: podcast ?? this.podcast,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) {
  return QueueItem(
    episode: json['episode'] == null ? null : Episode.fromJson(json['episode'] as Map<String, dynamic>),
    podcast: json['podcast'] == null ? null : Podcast.fromJson(json['podcast'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QueueItemToJson(QueueItem instance) => <String, dynamic>{
      'episode': instance.episode,
      'podcast': instance.podcast,
    };
