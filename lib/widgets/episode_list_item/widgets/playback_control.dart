// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/time.dart' as timeutils;
import 'package:phenopod/widgets/audio_player/widgets/preview_playback_controls.dart';

class PlaybackControl extends StatelessWidget {
  const PlaybackControl({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return StreamBuilder<Queue>(
        initialData: store.audioPlayer.getQueue(),
        stream: store.audioPlayer.watchQueue(),
        builder: (context, snapshot) {
          final queue = snapshot.data;

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Badge(
                badgeContent: _buildQueueBadge(context, queue),
                elevation: 0,
                padding: EdgeInsets.zero,
                position: BadgePosition(left: -12),
                badgeColor: Colors.transparent,
                toAnimate: true,
                animationType: BadgeAnimationType.scale,
                animationDuration: Duration.zero,
                child: Container(
                  height: 38,
                  width: 38,
                  alignment: Alignment.center,
                  child: queue.nowPlaying?.episode?.id != episode.id
                      ? _buildPlayButton(context, store)
                      : PreviewPlaybackControls(),
                ),
              ),
              Container(height: 6.0),
              _buildDuration(context),
            ],
          );
        });
  }

  Widget _buildQueueBadge(BuildContext context, Queue queue) {
    final nowPlaying = queue.nowPlaying;
    final audioTrack = queue.audioTracks.firstWhere(
      (t) => t.episode.id == episode.id,
      orElse: () => null,
    );

    if (queue.isEmpty || nowPlaying == null || audioTrack == null) {
      return Container();
    }

    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: TWColors.gray.shade700,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Text(
            '${audioTrack.position - nowPlaying.position}',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.15,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton(
    BuildContext context,
    Store store,
  ) {
    return StreamBuilder<PlaybackPosition>(
      initialData: store.playbackPosition.getByEpisode(episode.id),
      stream: store.playbackPosition.watchByEpisode(episode.id),
      builder: (context, snapshot) {
        final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

        final progressIndicator = CircularProgressIndicator(
          strokeWidth: 2.5,
          value: snapshot.data?.percentage ?? 0.0,
          valueColor: AlwaysStoppedAnimation<Color>(TWColors.purple.shade600),
          backgroundColor: TWColors.gray.shade300,
        );

        final playButton = Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                Icons.play_arrow_rounded,
                color: TWColors.gray.shade600,
                size: 20,
              ),
              onPressed: () {
                audioPlayerBloc.addQueueAction(
                  QueueAction.playTrack(
                    audioTrack: AudioTrack(episode: episode, podcast: podcast),
                  ),
                );
              },
            ),
          ),
        );

        return Container(
          height: 32,
          width: 32,
          child: Stack(
            children: <Widget>[
              progressIndicator,
              playButton,
            ],
          ),
        );
      },
    );
  }

  Widget _buildDuration(BuildContext context) {
    return Text(
      timeutils.formatDurationToWords(Duration(seconds: episode.duration)),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 11,
            color: TWColors.gray.shade900,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
    );
  }
}
