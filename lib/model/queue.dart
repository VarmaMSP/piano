import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:json_annotation/json_annotation.dart';
import 'package:phenopod/utils/request.dart';

import 'episode.dart';
import 'podcast.dart';

part 'queue.g.dart';

/// Used to store queue preference in preferences table
@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class QueuePreference extends Equatable {
  static const key = 'QUEUE_PREFERENCE';
  final int position;

  const QueuePreference({
    this.position,
  });

  factory QueuePreference.fromJson(Map<String, dynamic> json) {
    return _$QueuePreferenceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QueuePreferenceToJson(this);
  }

  @override
  List<Object> get props => [position];
}

@CopyWith()
class Queue extends Equatable {
  final int position;

  /// Store AudioTracks currently in audio player
  final List<AudioTrack> audioTracks;

  const Queue({
    this.position,
    this.audioTracks,
  });

  factory Queue.empty() {
    return Queue(
      position: -1,
      audioTracks: [],
    );
  }

  Queue add(AudioTrack audioTrack) {
    return Queue(
      position: 0,
      audioTracks: [audioTrack.copyWith(position: 0)],
    );
  }

  /// Returns a new queue with track in next play position
  Queue addToTop(AudioTrack audioTrack) {
    final trackPos = position + 1;
    return Queue(
      position: trackPos == 0 ? 0 : position,
      audioTracks: [
        ...audioTracks.sublist(0, trackPos),
        audioTrack.copyWith(position: trackPos),
        ...audioTracks
            .sublist(trackPos)
            .map((a) => a.copyWith(position: a.position + 1)),
      ],
    );
  }

  /// Returns a new queue with track in last play position
  Queue addToBottom(AudioTrack audioTrack) {
    final trackPos = audioTracks.length;
    return Queue(
      position: trackPos == 0 ? 0 : position,
      audioTracks: [
        ...audioTracks,
        audioTrack.copyWith(position: trackPos),
      ],
    );
  }

  /// Returns a new queue with track at given position remove
  Queue remove(int position) {
    return Queue(
      position: position != this.position
          ? this.position
          : position == audioTracks.length - 1 ? position - 1 : position + 1,
      audioTracks: [
        ...audioTracks.sublist(0, position),
        ...audioTracks.sublist(position + 1),
      ],
    );
  }

  /// Returns a new queue with updated now playing position
  Queue play(int position) {
    return Queue(position: position, audioTracks: audioTracks);
  }

  /// Returns a new queue with updated positions
  Queue changePosition(int from, int to) {
    final trackCount = audioTracks.length;

    var newPosition = position;
    if (position == from) {
      newPosition = to;
    } else if (position == to) {
      newPosition = to < from ? to + 1 : to - 1;
    }

    return Queue(
      position: newPosition,
      audioTracks: to < from
          ? [
              if (to > 0) ...audioTracks.sublist(0, to),
              audioTracks[from].copyWith(position: to),
              ...audioTracks
                  .sublist(to, from)
                  .map((t) => t.copyWith(position: t.position + 1)),
              if (from + 1 < trackCount) ...audioTracks.sublist(from + 1),
            ]
          : [
              if (from > 0) ...audioTracks.sublist(0, from),
              ...audioTracks
                  .sublist(from + 1, to + 1)
                  .map((t) => t.copyWith(position: t.position - 1)),
              audioTracks[from].copyWith(position: to),
              if (to + 1 < trackCount) ...audioTracks.sublist(to + 1),
            ],
    );
  }

  /// Returns a new queue with next track in active position
  Queue skipToNext() {
    return Queue(
      position: position + 1,
      audioTracks: audioTracks,
    );
  }

  /// Returns true if there are no tracks to play
  bool get isEmpty => position == -1;

  /// Returns true if next track is available
  bool get hasNextTrack => !isEmpty || position + 1 < audioTracks.length;

  /// Returns true if prev track is available
  bool get hasPreviousTrack => !isEmpty && position - 1 >= 0;

  /// Returns active audio track
  AudioTrack get nowPlaying => position != -1 ? audioTracks[position] : null;

  /// Returns preference
  QueuePreference get preference => QueuePreference(position: position);

  @override
  List<Object> get props => [position, audioTracks];

  @override
  String toString() => '{ position: $position tracks: ${audioTracks.length} }';
}

@CopyWith()
class AudioTrack extends Equatable {
  final int position;
  final Episode episode;
  final Podcast podcast;

  const AudioTrack({this.position, this.episode, this.podcast});

  audioservice.MediaItem toMediaItem() {
    return audioservice.MediaItem(
      id: episode.mediaUrl,
      artist: podcast.author,
      album: podcast.title,
      title: episode.title,
      artUri: '$thumbnailUrl/${podcast.urlParam}.jpg',
    );
  }

  @override
  List<Object> get props => [position, episode];
}
