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
  final bool enabled;

  const QueuePreference({
    this.position,
    this.enabled,
  });

  factory QueuePreference.fromJson(Map<String, dynamic> json) {
    return _$QueuePreferenceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QueuePreferenceToJson(this);
  }

  @override
  List<Object> get props => [position, enabled];
}

@CopyWith()
class Queue extends Equatable {
  final int position;

  /// The Queue can be disabled when user chooses to play only one track.
  final bool enabled;

  /// Store AudioTracks currently in audio player
  final List<AudioTrack> audioTracks;

  const Queue({
    this.position,
    this.enabled,
    this.audioTracks,
  });

  factory Queue.empty() {
    return Queue(
      position: -1,
      enabled: false,
      audioTracks: [],
    );
  }

  Queue add(AudioTrack audioTrack) {
    return Queue(
      enabled: false,
      position: 0,
      audioTracks: [audioTrack],
    );
  }

  /// Returns a new queue with track in next play position
  Queue addToTop(AudioTrack audioTrack) {
    final trackPos = position + 1;
    return Queue(
      enabled: true,
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
      enabled: true,
      position: trackPos == 0 ? 0 : position,
      audioTracks: [
        ...audioTracks,
        audioTrack.copyWith(position: trackPos),
      ],
    );
  }

  /// Returns a new queue with next track in active position
  Queue skipToNext() {
    return Queue(
      enabled: enabled,
      position: position + 1,
      audioTracks: audioTracks,
    );
  }

  /// Returns true if there are no tracks to play
  bool get isEmpty => position == -1;

  /// Returns true if next track is available
  bool get hasNextTrack =>
      !isEmpty && enabled || position + 1 < audioTracks.length;

  /// Returns true if prev track is available
  bool get hasPreviousTrack => !isEmpty && enabled && position - 1 >= 0;

  /// Returns active audio track
  AudioTrack get nowPlaying => position != -1 ? audioTracks[position] : null;

  /// Returns preference
  QueuePreference get preference => QueuePreference(
        enabled: enabled,
        position: position,
      );

  @override
  List<Object> get props => [position, enabled, audioTracks];

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
