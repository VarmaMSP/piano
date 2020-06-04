import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:phenopod/widgets/audio_player/widgets/action_button.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';

class AudioPlayerPreview extends StatelessWidget {
  const AudioPlayerPreview({
    Key key,
    @required this.animations,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
  }) : super(key: key);

  final BottomAppBarAnimations animations;
  final AudioPlayerActive state;
  final Function onPlay;
  final Function onPause;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.playerBackgroundColor,
      child: AnimatedBuilder(
        animation: animations.controller,
        builder: (_, __) {
          return animations.controller.value <
                  BottomAppBarAnimations.showAudioPlayerTopNavBarFrom
              ? FadeTransition(
                  opacity: animations.audioPlayerPreviewOpacity,
                  child: _buildPreview(),
                )
              : FadeTransition(
                  opacity: animations.audioPlayerTopNavBarOpacity,
                  child: _buildTopNavBar(),
                );
        },
      ),
      builder: (context, child) {
        return Container(
          height: 50,
          color: animations.playerBackgroundColor.value,
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: child,
        );
      },
    );
  }

  Widget _buildPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: animations.expandBottomAppBar,
          child: PodcastThumbnail(
            podcast: state.playingNow.podcast,
            size: PodcastThumbnailSize.xs,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: animations.expandBottomAppBar,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    state.playingNow.episode.title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
                  ),
                ],
              ),
            ),
          ),
        ),
        ActionButton(state: state, onPause: onPause, onResume: onPlay),
      ],
    );
  }

  Widget _buildTopNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Transform.translate(
          offset: Offset(-8, 0),
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.expand_more,
              color: TWColors.gray.shade700,
              size: 24,
            ),
            onPressed: animations.collapseBottomAppBar,
          ),
        ),
      ],
    );
  }
}
