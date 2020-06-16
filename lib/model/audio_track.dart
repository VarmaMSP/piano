import 'package:equatable/equatable.dart';

import 'episode.dart';
import 'podcast.dart';

class Queue extends Equatable {
  final List<AudioTrack> audioTracks;

  Queue(this.audioTracks);

  @override
  List<Object> get props => [audioTracks];
}

class AudioTrack extends Equatable {
  final int position;
  final Episode episode;
  final Podcast podcast;

  AudioTrack(this.position, this.episode, this.podcast);

  @override
  List<Object> get props => [position];
}
