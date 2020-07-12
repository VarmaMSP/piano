import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum EpisodeOption {
  playNext,
  addToQueue,
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

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
        return EpisodeOption.values
            .map(
              (option) => PopupMenuItem<EpisodeOption>(
                value: option,
                height: 42,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: TWColors.gray.shade700),
                child: Text(_episodeOptionsToString(option)),
              ),
            )
            .toList();
      },
      onSelected: (option) {
        switch (option) {
          case EpisodeOption.playNext:
            audioPlayerBloc.transistionQueue(
              QueueTransistion.addToQueueTop(
                audioTrack: AudioTrack(
                  episode: episode,
                  podcast: podcast,
                ),
              ),
            );
            break;
          case EpisodeOption.addToQueue:
            audioPlayerBloc.transistionQueue(
              QueueTransistion.addToQueueBottom(
                audioTrack: AudioTrack(
                  episode: episode,
                  podcast: podcast,
                ),
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
    }
  }
}
