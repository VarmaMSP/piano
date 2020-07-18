// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart' hide Podcast;
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/bloc/episode_actions_bloc.dart';
import 'package:phenopod/model/main.dart';

enum EpisodeOption {
  playNext,
  addToQueue,
  goToPodcast,
  download,
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.episode,
    @required this.podcast,
    @required this.options,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;
  final List<EpisodeOption> options;

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return PopupMenuButton<EpisodeOption>(
      icon: Icon(
        Icons.more_vert,
        color: TWColors.gray.shade700,
        size: 22,
      ),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (BuildContext context) {
        return options
            .map(
              (option) => PopupMenuItem<EpisodeOption>(
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
          case EpisodeOption.playNext:
            audioPlayerBloc.transitionQueue(
              QueueTransition.addToQueueTop(
                audioTrack: AudioTrack(
                  episode: episode,
                  podcast: podcast,
                ),
              ),
            );
            break;

          case EpisodeOption.addToQueue:
            audioPlayerBloc.transitionQueue(
              QueueTransition.addToQueueBottom(
                audioTrack: AudioTrack(
                  episode: episode,
                  podcast: podcast,
                ),
              ),
            );
            break;

          case EpisodeOption.goToPodcast:
            Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
              Screen.podcast(urlParam: podcast.urlParam),
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
        }
      },
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
      case EpisodeOption.download:
        return 'Download';
    }
  }
}
