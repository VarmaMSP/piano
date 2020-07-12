import 'package:flutter/material.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum QueueOptions {
  playNext,
  moveToBottom,
  removeFromQueue,
  goToPodcast,
  goToEpisode,
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.trackCount,
    @required this.nowPlayingPosition,
    @required this.audioTrack,
    @required this.lighten,
    @required this.transitionQueue,
  }) : super(key: key);

  final int trackCount;
  final int nowPlayingPosition;
  final AudioTrack audioTrack;
  final bool lighten;
  final void Function(QueueTransition) transitionQueue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<QueueOptions>(
      icon: Icon(
        Icons.more_vert,
        color: lighten ? TWColors.gray.shade500 : TWColors.gray.shade700,
        size: 22,
      ),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (context) {
        return QueueOptions.values
            .map(
              (option) => PopupMenuItem<QueueOptions>(
                value: option,
                height: 48,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: TWColors.gray.shade700),
                child: Text(_queueOptionsToString(option)),
              ),
            )
            .toList();
      },
      onSelected: (option) {
        switch (option) {
          case QueueOptions.playNext:
            if (audioTrack.position != nowPlayingPosition) {
              transitionQueue(QueueTransition.changeTrackPosition(
                from: audioTrack.position,
                to: nowPlayingPosition + 1 < trackCount
                    ? nowPlayingPosition + 1
                    : trackCount - 1,
              ));
            }
            break;

          case QueueOptions.moveToBottom:
            transitionQueue(QueueTransition.changeTrackPosition(
              from: audioTrack.position,
              to: trackCount - 1,
            ));
            break;

          case QueueOptions.removeFromQueue:
            transitionQueue(QueueTransition.removeTrack(
              position: audioTrack.position,
            ));
            break;

          case QueueOptions.goToPodcast:
            Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
              Screen.podcast(urlParam: audioTrack.podcast.urlParam),
            );
            Navigator.of(context, rootNavigator: true).pop();
            break;

          case QueueOptions.goToEpisode:
            Navigator.of(context, rootNavigator: true).pop();
            break;
        }
      },
    );
  }

  // ignore: missing_return
  String _queueOptionsToString(QueueOptions option) {
    switch (option) {
      case QueueOptions.playNext:
        return 'Play next';
      case QueueOptions.moveToBottom:
        return 'Move to bottom';
      case QueueOptions.removeFromQueue:
        return 'Remove from queue';
      case QueueOptions.goToPodcast:
        return 'Go to podcast';
      case QueueOptions.goToEpisode:
        return 'Go to episode';
    }
  }
}
