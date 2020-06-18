import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'episode.dart';
import 'podcast.dart';

part 'audio_player.g.dart';

@CopyWith()
class AudioPlayerSnapshot extends Equatable {
  final Queue queue;

  AudioPlayerSnapshot({this.queue});

  @override
  List<Object> get props => [queue];
}

@CopyWith()
class Queue extends Equatable {
  final int position;
  final bool enabled;
  final List<AudioTrack> audioTracks;

  Queue({this.position, this.enabled, this.audioTracks});

  @override
  List<Object> get props => [position, enabled, audioTracks];
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
