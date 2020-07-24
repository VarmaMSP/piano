part of 'main.dart';

@CopyWith()
class Queue extends Equatable {
  final int position;
  final List<AudioTrack> audioTracks;

  const Queue({
    @required this.position,
    @required this.audioTracks,
  });

  factory Queue.empty() => Queue(
        position: -1,
        audioTracks: [],
      );

  Queue addToTop(AudioTrack audioTrack) => Queue(
        position: when<int, int>({
          (p) => p == -1: (_) => 0,
          (_) => true: (p) => p,
        })(position),
        audioTracks: [
          if (position >= 0) ...audioTracks.sublist(0, position + 1),
          audioTrack.copyWith(position: position + 1),
          if (position + 1 < audioTracks.length)
            ...audioTracks
                .sublist(position + 1)
                .map((a) => a.copyWith(position: a.position + 1)),
        ],
      );

  Queue addToBottom(AudioTrack audioTrack) => Queue(
        position: when<int, int>({
          (p) => p == -1: (_) => 0,
          (_) => true: (p) => p,
        })(position),
        audioTracks: [
          ...audioTracks,
          audioTrack.copyWith(position: audioTracks.length),
        ],
      );

  Queue changeTrackPosition(int from, int to) => Queue(
        position: when<int, int>({
          (p) => p == from: (_) => to,
          (p) => p >= to && p < from: (p) => p + 1,
          (p) => p > from && p <= to: (p) => p - 1,
          (_) => true: (p) => p,
        })(position),
        audioTracks: to < from
            ? [
                if (to > 0) ...audioTracks.sublist(0, to),
                audioTracks[from].copyWith(position: to),
                ...audioTracks
                    .sublist(to, from)
                    .map((t) => t.copyWith(position: t.position + 1)),
                if (from + 1 < audioTracks.length)
                  ...audioTracks.sublist(from + 1),
              ]
            : [
                if (from > 0) ...audioTracks.sublist(0, from),
                ...audioTracks
                    .sublist(from + 1, to + 1)
                    .map((t) => t.copyWith(position: t.position - 1)),
                audioTracks[from].copyWith(position: to),
                if (to + 1 < audioTracks.length) ...audioTracks.sublist(to + 1),
              ],
      );

  Queue removeTrack(int pos) => Queue(
        position: when<int, int>({
          (p) => p >= pos: (p) => p - 1,
          (_) => true: (p) => p,
        })(position),
        audioTracks: [
          if (pos > 0) ...audioTracks.sublist(0, pos),
          if (pos + 1 < audioTracks.length)
            ...audioTracks
                .sublist(pos + 1)
                .map((t) => t.copyWith(position: t.position - 1)),
        ],
      );

  Queue playTrackAt(int pos) => Queue(
        position: when<int, int>({
          (_) => pos >= 0 && pos < audioTracks.length: (_) => pos,
          (_) => true: (p) => p,
        })(position),
        audioTracks: audioTracks,
      );

  Queue skipToNextTrack() => Queue(
        position: when<int, int>({
          (p) => p + 1 < audioTracks.length: (p) => p + 1,
          (_) => true: (p) => p,
        })(position),
        audioTracks: audioTracks,
      );

  Queue skipToPrevTrack() => Queue(
        position: when<int, int>({
          (p) => p - 1 >= 0: (p) => p - 1,
          (_) => true: (p) => p,
        })(position),
        audioTracks: audioTracks,
      );

  /// Returns true if there are no tracks to play
  bool get isEmpty => position == -1;

  /// Returns active audio track
  AudioTrack get nowPlaying => isEmpty ? null : audioTracks[position];

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

  audioservice.MediaItem toMediaItem({String filePath}) {
    return audioservice.MediaItem(
      id: filePath ?? episode.mediaUrl,
      artist: podcast.author,
      album: podcast.title,
      title: episode.title,
      artUri: '$thumbnailUrl/${podcast.urlParam}.jpg',
    );
  }

  @override
  List<Object> get props => [position, episode];
}
