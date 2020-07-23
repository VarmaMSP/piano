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
