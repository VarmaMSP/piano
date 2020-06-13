import 'package:equatable/equatable.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/utils/request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'episode.dart';
import 'podcast.dart';

part 'queue.g.dart';

class Queue extends Equatable {
  const Queue({this.items});

  final List<QueueItem> items;

  QueueItem getQueueItem({String episodeId, String mediaUri}) {
    if (episodeId != null) {
      return items.firstWhere((QueueItem queueItem) => queueItem.episode.id == episodeId);
    }
    if (mediaUri != null) {
      return items.firstWhere((QueueItem queueItem) => queueItem.episode.mediaUrl == mediaUri);
    }
    return null;
  }

  @override
  List<Object> get props => items.map((QueueItem item) => item.episode).toList();
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class QueueItem extends Equatable {
  final Episode episode;
  final Podcast podcast;

  const QueueItem({@required this.episode, @required this.podcast});

  factory QueueItem.fromJson(Map<String, dynamic> json) {
    return _$QueueItemFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QueueItemToJson(this);
  }

  MediaItem toMediaItem() {
    return MediaItem(
      id: episode.mediaUrl,
      artist: podcast.author,
      album: podcast.title,
      title: episode.title,
      artUri: '$thumbnailUrl/${podcast.urlParam}.jpg',
    );
  }

  @override
  List<Object> get props => <Object>[episode];
}
