import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'episode.dart';
import 'podcast.dart';

part 'audio_player.g.dart';

@CopyWith()
class AudioPlayerSnapshot extends Equatable {
  final Queue queue;

  AudioPlayerSnapshot({this.queue});

  factory AudioPlayerSnapshot.empty() {
    return AudioPlayerSnapshot(
      queue: Queue(
        audioTracks: [],
        position: -1,
        enabled: false,
      ),
    );
  }

  factory AudioPlayerSnapshot.singleTrack(AudioTrack audioTrack) {
    return AudioPlayerSnapshot(
      queue: Queue(
        audioTracks: [audioTrack],
        position: 0,
        enabled: false,
      ),
    );
  }

  factory AudioPlayerSnapshot.singleTrackWithQueue(AudioTrack audioTrack) {
    return AudioPlayerSnapshot(
      queue: Queue(
        audioTracks: [audioTrack],
        position: 0,
        enabled: true,
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

  /// true if there are no tracks to play
  bool get isEmpty => queue.isEmpty;

  /// return current audio track
  AudioTrack get nowPlaying => queue.nowPlaying;

  /// Returns queue if enabled
  Queue get enabledQueue => queue.enabled ? queue : null;

  @override
  List<Object> get props => [queue];

  @override
  String toString() => '{ Queue: ${queue.toString()} }';
}

/// The Queue can be disabled when user chooses to play only one track.
@CopyWith()
class Queue extends Equatable {
  final int position;
  final bool enabled;
  final List<AudioTrack> audioTracks;

  Queue({this.position, this.enabled, this.audioTracks});

  Queue addToTop(AudioTrack audioTrack) {
    final trackPos = position + 1;
    return Queue(enabled: true, audioTracks: [
      ...audioTracks.sublist(0, trackPos),
      audioTrack.copyWith(position: trackPos),
      ...audioTracks
          .sublist(trackPos)
          .map((a) => a.copyWith(position: a.position + 1)),
    ]);
  }

  Queue addToBottom(AudioTrack audioTrack) {
    final trackPos = audioTracks.length;
    return Queue(enabled: true, audioTracks: [
      ...audioTracks,
      audioTrack.copyWith(position: trackPos),
    ]);
  }

  bool get isEmpty => position == -1;

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

  @override
  List<Object> get props => [position, episode];
}
