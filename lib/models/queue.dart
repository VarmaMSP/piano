import 'package:equatable/equatable.dart';
import 'package:audio_service/audio_service.dart';
import 'package:phenopod/utils/request.dart';

import 'episode.dart';
import 'podcast.dart';

class Queue extends Equatable {
  const Queue({this.items});

  final List<QueueItem> items;

  QueueItem getQueueItem({String episodeId, String mediaUri}) {
    if (episodeId != null) {
      return items.firstWhere(
          (QueueItem queueItem) => queueItem.episode.id == episodeId);
    }

    if (mediaUri != null) {
      return items.firstWhere(
          (QueueItem queueItem) => queueItem.episode.mediaUrl == mediaUri);
    }

    return null;
  }

  @override
  List<Object> get props =>
      items.map((QueueItem item) => item.episode).toList();
}

class QueueItem extends Equatable {
  const QueueItem({this.episode, this.podcast});

  final Episode episode;
  final Podcast podcast;

  MediaItem toMediaItem() {
    return MediaItem(
      id: episode.mediaUrl,
      album: podcast.title,
      title: episode.title,
      artUri: '$thumbnailUrl/${podcast.urlParam}.jpg',
    );
  }

  @override
  List<Object> get props => <Object>[episode];
}
