part of 'main.dart';

@freezed
abstract class PodcastAction with _$PodcastAction {
  const factory PodcastAction.subscribe({
    @required Podcast podcast,
  }) = _Subscribe;

  const factory PodcastAction.unsubscribe({
    @required Podcast podcast,
  }) = _Unsubscribe;
}

@freezed
abstract class EpisodeAction with _$EpisodeAction {
  const factory EpisodeAction.startDownload({
    @required Episode episode,
    @required Podcast podcast,
  }) = _StartDownload;

  const factory EpisodeAction.cancelDownload({
    @required String episodeId,
  }) = _CancelDownload;
}

@freezed
abstract class QueueAction with _$QueueAction {
  const factory QueueAction.play({
    @required AudioTrack audioTrack,
  }) = _Play;

  const factory QueueAction.addToQueueTop({
    @required AudioTrack audioTrack,
  }) = _AddToQueueTop;

  const factory QueueAction.addToQueueBottom({
    @required AudioTrack audioTrack,
  }) = _AddToQueueBottom;

  const factory QueueAction.changeTrackPosition({
    @required int from,
    @required int to,
  }) = _ChangeTrackPosition;

  const factory QueueAction.playTrack({
    @required int position,
  }) = _PlayTrack;

  const factory QueueAction.removeTrack({
    @required int position,
  }) = _RemoveTrack;

  const factory QueueAction.clearQueue() = _ClearQueue;
}
