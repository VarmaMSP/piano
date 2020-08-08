// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/blocs/episode_actions_bloc.dart';
import 'package:phenopod/models/main.dart';

enum EpisodeOption {
  playNext,
  addToQueue,
  goToPodcast,
  goToEpisode,
  moveToQueueBottom,
  removeFromQueue,
  download,
  cancelDownload,
  deleteFromDownloads,
}

class EpisodeMenu extends StatelessWidget {
  final bool fromPlayer;
  final Episode episode;
  final Podcast podcast;
  final AudioTrack audioTrack;
  final List<EpisodeOption> options;
  final bool lighten;
  final int trackCount;
  final int nowPlayingPosition;

  const EpisodeMenu({
    Key key,
    this.fromPlayer = false,
    this.episode,
    this.podcast,
    this.audioTrack,
    this.options,
    this.lighten = false,
    this.trackCount,
    this.nowPlayingPosition,
  }) : super(key: key);

  factory EpisodeMenu.episodeListItem({
    Key key,
    @required Episode episode,
    @required Podcast podcast,
    @required EpisodeMeta episodeMeta,
  }) {
    return EpisodeMenu(
      key: key,
      episode: episode,
      podcast: podcast,
      audioTrack: episodeMeta?.audioTrack,
      options: [
        EpisodeOption.playNext,
        if (episodeMeta?.audioTrack == null)
          EpisodeOption.addToQueue
        else
          EpisodeOption.removeFromQueue,
        _downloadOption(episodeMeta?.downloadProgress)
      ],
    );
  }

  factory EpisodeMenu.subscriptionListItem({
    Key key,
    @required Episode episode,
    @required Podcast podcast,
    @required EpisodeMeta episodeMeta,
  }) {
    return EpisodeMenu(
      key: key,
      episode: episode,
      podcast: podcast,
      audioTrack: episodeMeta?.audioTrack,
      options: [
        EpisodeOption.playNext,
        if (episodeMeta?.audioTrack == null)
          EpisodeOption.addToQueue
        else
          EpisodeOption.removeFromQueue,
        EpisodeOption.goToPodcast,
        _downloadOption(episodeMeta?.downloadProgress)
      ],
    );
  }

  factory EpisodeMenu.downloadListItem({
    Key key,
    @required Episode episode,
    @required Podcast podcast,
    @required DownloadProgress downloadProgress,
  }) {
    return EpisodeMenu(
      key: key,
      episode: episode,
      podcast: podcast,
      options: [
        EpisodeOption.playNext,
        EpisodeOption.addToQueue,
        EpisodeOption.goToPodcast,
        _downloadOption(downloadProgress),
      ],
    );
  }

  factory EpisodeMenu.QueueListItem({
    Key key,
    @required AudioTrack audioTrack,
    @required bool lighten,
    @required int trackCount,
    @required int nowPlayingPosition,
    @required DownloadProgress downloadProgress,
  }) {
    return EpisodeMenu(
      key: key,
      fromPlayer: true,
      episode: audioTrack.episode,
      podcast: audioTrack.podcast,
      audioTrack: audioTrack,
      options: [
        EpisodeOption.playNext,
        EpisodeOption.moveToQueueBottom,
        EpisodeOption.removeFromQueue,
        EpisodeOption.goToPodcast,
        EpisodeOption.goToEpisode,
        _downloadOption(downloadProgress),
      ],
      lighten: lighten,
      trackCount: trackCount,
      nowPlayingPosition: nowPlayingPosition,
    );
  }

  static EpisodeOption _downloadOption(DownloadProgress downloadProgress) {
    if (downloadProgress == null) {
      return EpisodeOption.download;
    } else if (downloadProgress.isComplete) {
      return EpisodeOption.deleteFromDownloads;
    } else {
      return EpisodeOption.cancelDownload;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 38,
      child: PopupMenuButton<EpisodeOption>(
        icon: Icon(
          Icons.more_vert_rounded,
          color: audioTrack != null && lighten
              ? TWColors.gray.shade500
              : TWColors.gray.shade600,
          size: 24,
        ),
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        itemBuilder: (context) {
          return options
              .map(
                (option) => PopupMenuItem<EpisodeOption>(
                  value: option,
                  height: 42,
                  textStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: TWColors.gray.shade900, fontSize: 16.5),
                  child: Text(_episodeOptionsToString(option)),
                ),
              )
              .toList();
        },
        onSelected: (option) => _handleOnPress(context, option),
      ),
    );
  }

  // ignore: missing_return
  String _episodeOptionsToString(EpisodeOption option) {
    switch (option) {
      case EpisodeOption.playNext:
        return 'Play next';
      case EpisodeOption.addToQueue:
        return 'Add to queue';
      case EpisodeOption.goToPodcast:
        return 'Go to podcast';
      case EpisodeOption.goToEpisode:
        return 'Go to episode';
      case EpisodeOption.moveToQueueBottom:
        return 'Move to bottom';
      case EpisodeOption.removeFromQueue:
        return 'Remove from queue';
      case EpisodeOption.download:
        return 'Download';
      case EpisodeOption.cancelDownload:
        return 'Cancel download';
      case EpisodeOption.deleteFromDownloads:
        return 'Delete from downloads';
    }
  }

  void _handleOnPress(BuildContext context, EpisodeOption option) {
    switch (option) {
      case EpisodeOption.playNext:
        Provider.of<AudioPlayerBloc>(context, listen: false).addQueueAction(
          QueueAction.addToQueueTop(
            audioTrack: AudioTrack(
              episode: episode,
              podcast: podcast,
            ),
          ),
        );
        break;

      case EpisodeOption.addToQueue:
        Provider.of<AudioPlayerBloc>(context, listen: false).addQueueAction(
          QueueAction.addToQueueBottom(
            audioTrack: AudioTrack(
              episode: episode,
              podcast: podcast,
            ),
          ),
        );
        break;

      case EpisodeOption.goToPodcast:
        if (fromPlayer) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
          AppScreen.podcastScreen(
            urlParam: podcast.urlParam,
            placeholder: PodcastPlaceholder(
              title: podcast.title,
              author: podcast.author,
              isSubscribed: false,
            ),
          ),
        );
        break;

      case EpisodeOption.goToEpisode:
        if (fromPlayer) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
          AppScreen.episodeScreen(urlParam: episode.urlParam),
        );
        break;

      case EpisodeOption.moveToQueueBottom:
        Provider.of<AudioPlayerBloc>(context, listen: false).addQueueAction(
          QueueAction.changeTrackPosition(
            from: audioTrack.position,
            to: trackCount - 1,
          ),
        );
        break;

      case EpisodeOption.removeFromQueue:
        Provider.of<AudioPlayerBloc>(context, listen: false).addQueueAction(
          QueueAction.removeTrack(
            position: audioTrack.position,
          ),
        );
        break;

      case EpisodeOption.download:
        Provider.of<EpisodeActionsBloc>(context, listen: false).addAction(
          EpisodeAction.startDownload(
            episode: episode,
            podcast: podcast,
          ),
        );
        break;

      case EpisodeOption.cancelDownload:
      case EpisodeOption.deleteFromDownloads:
        Provider.of<EpisodeActionsBloc>(context, listen: false).addAction(
          EpisodeAction.cancelDownload(episodeId: episode.id),
        );
        break;
    }
  }
}
