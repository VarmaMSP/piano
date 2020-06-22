import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:audio_service/audio_service.dart' as audioservice;
import 'package:phenopod/utils/request.dart';

import 'episode.dart';
import 'podcast.dart';

part 'audio_player.g.dart';

@CopyWith()
class AudioPlayerSnapshot extends Equatable {
  final Queue queue;

  AudioPlayerSnapshot({this.queue});

  factory AudioPlayerSnapshot.empty() {
    return AudioPlayerSnapshot(queue: Queue());
  }

  factory AudioPlayerSnapshot.singleTrack(AudioTrack audioTrack) {
    return AudioPlayerSnapshot(
      queue: Queue(
        enabled: false,
        position: 0,
        audioTracks: [audioTrack],
      ),
    );
  }

  factory AudioPlayerSnapshot.singleTrackWithQueue(AudioTrack audioTrack) {
    return AudioPlayerSnapshot(
      queue: Queue(
        enabled: true,
        position: 0,
        audioTracks: [audioTrack],
      ),
    );
  }

  AudioPlayerSnapshot add(AudioTrack audioTrack) {
    return AudioPlayerSnapshot.singleTrack(audioTrack);
  }

  AudioPlayerSnapshot addToQueueTop(AudioTrack audioTrack) {
    return isEmpty
        ? AudioPlayerSnapshot.singleTrackWithQueue(audioTrack)
        : AudioPlayerSnapshot(queue: queue.addToTop(audioTrack));
  }

  AudioPlayerSnapshot addToQueueBottom(AudioTrack audioTrack) {
    return isEmpty
        ? AudioPlayerSnapshot.singleTrackWithQueue(audioTrack)
        : AudioPlayerSnapshot(queue: queue.addToBottom(audioTrack));
  }

  AudioPlayerSnapshot skipToNext() {
    return hasNextTrack ? AudioPlayerSnapshot(queue: queue.skipToNext()) : this;
  }

  /// True if there are no tracks to play
  bool get isEmpty => queue.isEmpty;

  /// True if queue is enabled
  bool get isQueueEnabled => queue.enabled;

  /// Returns current audio track
  AudioTrack get nowPlaying => queue.nowPlaying;

  /// Returns true if next track is available
  bool get hasNextTrack => queue.hasNextTrack;

  /// Returns true if prev track is available
  bool get hasPreviousTrack => queue.hasPreviousTrack;

  /// Returns queue if enabled
  Queue get enabledQueue => queue.enabled ? queue : null;

  @override
  List<Object> get props => [queue];

  @override
  String toString() => '{ Queue: ${queue.toString()} }';
}

@CopyWith()
class Queue extends Equatable {
  final int position;

  /// The Queue can be disabled when user chooses to play only one track.
  final bool enabled;

  /// Store AudioTracks currently in audio player
  final List<AudioTrack> audioTracks;

  Queue({
    this.position = -1,
    this.enabled = false,
    this.audioTracks = const [],
  });

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

  Queue skipToNext() {
    return Queue(
      enabled: enabled,
      position: position + 1,
      audioTracks: audioTracks,
    );
  }

  bool get isEmpty => position == -1;

  bool get hasNextTrack =>
      !isEmpty && enabled || position + 1 < audioTracks.length;

  bool get hasPreviousTrack => !isEmpty && enabled && position - 1 >= 0;

  AudioTrack get nowPlaying => position != -1 ? audioTracks[position] : null;

  @override
  List<Object> get props => [position, enabled, audioTracks];

  @override
  String toString() =>
      '{ position: $position, enabled: $enabled, tracks: ${audioTracks.length} }';
}

@CopyWith()
class AudioTrack extends Equatable {
  final int position;
  final Episode episode;
  final Podcast podcast;

  AudioTrack({this.position, this.episode, this.podcast});

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
