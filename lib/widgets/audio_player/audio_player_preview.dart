import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/audio_player/widgets/preview_playback_controls.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayerPreview extends StatelessWidget {
  const AudioPlayerPreview({
    Key key,
    @required this.animations,
    @required this.nowPlaying,
  }) : super(key: key);

  final BottomAppBarAnimation animations;
  final AudioTrack nowPlaying;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animations.audioPlayerPreviewOpacity,
      child: SizeTransition(
        axis: Axis.vertical,
        axisAlignment: 1.0,
        sizeFactor: animations.audioPlayerPreviewSizeFactor,
        child: Container(
          height: 50,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: animations.expandBottomAppBar,
          child: PodcastThumbnail(
            podcast: nowPlaying.podcast,
            size: PodcastThumbnailSize.xs,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: animations.expandBottomAppBar,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    nowPlaying.episode.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: TWColors.gray.shade800),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        PreviewPlaybackControls(),
      ],
    );
  }
}
