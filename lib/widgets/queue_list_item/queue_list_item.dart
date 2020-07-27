// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/box.dart';
import 'package:phenopod/widgets/episode_menu.dart';
import 'thumbnail.dart';

class QueueListItem extends StatelessWidget {
  QueueListItem({
    Key key,
    @required this.trackCount,
    @required this.nowPlayingPosition,
    @required this.audioTrack,
    @required this.dragAnimation,
  });

  static final double itemHeight = 80;

  final int trackCount;
  final int nowPlayingPosition;
  final AudioTrack audioTrack;
  final Animation<double> dragAnimation;

  @override
  Widget build(BuildContext context) {
    final t = dragAnimation.value;

    final color = nowPlayingPosition == audioTrack.position
        ? Colors.grey.shade200
        : Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    final lighten = audioTrack.position < nowPlayingPosition;
    final background = ({bool alignRight}) => Container(
          constraints: BoxConstraints.expand(),
          padding: alignRight
              ? EdgeInsets.only(right: 12)
              : EdgeInsets.only(left: 12),
          alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
          color: TWColors.red.shade600,
          child: Icon(Icons.delete_rounded, color: Colors.white, size: 28),
        );

    final store = Provider.of<Store>(context);

    return Dismissible(
      key: Key(audioTrack.episode.id),
      background: background(alignRight: false),
      secondaryBackground: background(alignRight: true),
      onDismissed: (direction) => Provider.of<AudioPlayerBloc>(
        context,
        listen: false,
      ).addQueueAction(
        QueueAction.removeTrack(position: audioTrack.position),
      ),
      child: Box(
        color: color,
        elevation: elevation,
        alignment: Alignment.center,
        height: itemHeight,
        child: GestureDetector(
          onTap: () => Provider.of<AudioPlayerBloc>(
            context,
            listen: false,
          ).addQueueAction(
            QueueAction.playTrackAt(position: audioTrack.position),
          ),
          child: StreamBuilder<DownloadProgress>(
            stream:
                store.audioFile.watchDownloadProgress(audioTrack.episode.id),
            builder: (context, snapshot) {
              return Container(
                constraints: BoxConstraints.expand(height: itemHeight),
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHandle(context, lighten: lighten),
                    Thumbnail(podcast: audioTrack.podcast, lighten: lighten),
                    Expanded(
                      child: _buildDetails(
                        context,
                        snapshot.data,
                        lighten: lighten,
                      ),
                    ),
                    EpisodeMenu.QueueListItem(
                      audioTrack: audioTrack,
                      trackCount: trackCount,
                      lighten: lighten,
                      nowPlayingPosition: nowPlayingPosition,
                      downloadProgress: snapshot.data,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context, {bool lighten}) {
    final dragIcon = Container(
      padding: EdgeInsets.only(left: 6),
      child: Icon(
        MdiIcons.dragVertical,
        color: lighten ? TWColors.gray.shade600 : TWColors.gray.shade900,
        size: 24,
      ),
    );

    final position = Container(
      width: 26,
      padding: EdgeInsets.only(right: 8),
      child: nowPlayingPosition == audioTrack.position
          ? Icon(
              Icons.play_arrow_rounded,
              color: TWColors.gray.shade700,
              size: 18,
            )
          : Text(
              '${audioTrack.position - nowPlayingPosition}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: lighten
                        ? TWColors.gray.shade600
                        : TWColors.gray.shade900,
                  ),
            ),
    );

    return Handle(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [dragIcon, position])
        ],
      ),
    );
  }

  Widget _buildDetails(
    BuildContext context,
    DownloadProgress downloadProgress, {
    bool lighten,
  }) {
    final textColor = lighten ? TWColors.gray.shade600 : TWColors.gray.shade900;

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            audioTrack.episode.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            audioTrack.podcast.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: downloadProgress == null
                    ? Container()
                    : downloadProgress.isComplete &&
                            downloadProgress.downloadPercentage == 1.0
                        ? Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              MdiIcons.checkUnderlineCircle,
                              size: 14,
                              color: TWColors.blue.shade700,
                            ),
                          )
                        : Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.only(right: 12, bottom: 2),
                            child: CircularProgressIndicator(
                              value: downloadProgress.downloadPercentage,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                TWColors.blue.shade700,
                              ),
                              backgroundColor: TWColors.gray.shade400,
                              strokeWidth: 2.5,
                            ),
                          ),
              ),
              Text(
                '${formatDuration(seconds: audioTrack.episode.duration)}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: textColor, fontSize: 11.75),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
