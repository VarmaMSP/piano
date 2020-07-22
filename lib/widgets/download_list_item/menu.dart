// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart' hide Podcast;
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

enum AudioFileOption {
  playNext,
  addToQueue,
  goToPodcast,
  cancelDownload,
  deleteFormDownloads,
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.audioFile,
  }) : super(key: key);

  final AudioFile audioFile;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AudioFileOption>(
      icon: Icon(
        Icons.more_vert,
        color: TWColors.gray.shade700,
        size: 22,
      ),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (context) {
        return [
          AudioFileOption.playNext,
          AudioFileOption.addToQueue,
          AudioFileOption.goToPodcast,
          if (audioFile.isDownloading || audioFile.isQueued)
            AudioFileOption.cancelDownload
          else
            AudioFileOption.deleteFormDownloads,
        ]
            .map(
              (option) => PopupMenuItem<AudioFileOption>(
                value: option,
                height: 46,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: TWColors.gray.shade800),
                child: Text(_episodeOptionsToString(option)),
              ),
            )
            .toList();
      },
      onSelected: (option) {
        switch (option) {
          case AudioFileOption.playNext:
            Provider.of<AudioPlayerBloc>(
              context,
              listen: false,
            ).transitionQueue(
              QueueTransition.addToQueueTop(
                audioTrack: AudioTrack(
                  episode: audioFile.episode,
                  podcast: audioFile.podcast,
                ),
              ),
            );
            break;

          case AudioFileOption.addToQueue:
            Provider.of<AudioPlayerBloc>(
              context,
              listen: false,
            ).transitionQueue(
              QueueTransition.addToQueueBottom(
                audioTrack: AudioTrack(
                  episode: audioFile.episode,
                  podcast: audioFile.podcast,
                ),
              ),
            );
            break;

          case AudioFileOption.goToPodcast:
            Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
              Screen.podcast(
                urlParam: audioFile.podcast.urlParam,
                title: audioFile.podcast.title,
                author: audioFile.podcast.author,
              ),
            );
            break;

          case AudioFileOption.cancelDownload:
            Provider.of<Store>(
              context,
              listen: false,
            ).audioFile.deleteByEpisode(audioFile.episode.id);
            break;

          case AudioFileOption.deleteFormDownloads:
            Provider.of<Store>(
              context,
              listen: false,
            ).audioFile.deleteByEpisode(audioFile.episode.id);
            break;
        }
      },
    );
  }

  // ignore: missing_return
  String _episodeOptionsToString(AudioFileOption option) {
    switch (option) {
      case AudioFileOption.playNext:
        return 'Play next';
      case AudioFileOption.addToQueue:
        return 'Add to queue';
      case AudioFileOption.goToPodcast:
        return 'Go to podcast';
      case AudioFileOption.cancelDownload:
        return 'Cancel download';
      case AudioFileOption.deleteFormDownloads:
        return 'Delete from downloads';
    }
  }
}
