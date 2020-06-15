import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/widgets/audio_player/widgets/playback_controls.dart';
import 'package:phenopod/widgets/html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({
    Key key,
    @required this.animations,
    @required this.nowPlaying,
    @required this.onPlay,
    @required this.onPause,
    @required this.onSeek,
  }) : super(key: key);

  final BottomAppBarAnimations animations;
  final QueueItem nowPlaying;
  final void Function() onPlay;
  final void Function() onPause;
  final void Function(int) onSeek;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.playerBackgroundColor,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: TWColors.gray.shade200),
                ),
                color: animations.playerBackgroundColor.value,
              ),
              child: Column(
                children: <Widget>[
                  _buildDetails(),
                  Container(height: 10),
                  PlaybackControls(
                    onPlay: onPlay,
                    onPause: onPause,
                    onSeek: onSeek,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 14,
                    right: 14,
                    bottom: 48,
                  ),
                  child: HTML(
                    id: nowPlaying.episode.id,
                    document: nowPlaying.episode.description,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetails() {
    final episodeTitle = Container(
      height: 62,
      transform: Matrix4.translationValues(0, -4, 0),
      alignment: Alignment.topCenter,
      child: Text(
        nowPlaying.episode.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          height: 1.4,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: TWColors.gray.shade800,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final artWork = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: '$thumbnailUrl/${nowPlaying.podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: 105,
        width: 105,
        placeholder: (BuildContext context, String url) => Container(
          height: 105,
          width: 105,
          color: TWColors.gray.shade300,
        ),
      ),
    );

    final publishDate = Text(
      'Published on 24 May, 2020',
      style: TextStyle(
        fontSize: 13.5,
        letterSpacing: 0.25,
        color: TWColors.gray.shade800,
      ),
    );

    final podcastTitle = RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'by ',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 0.25,
              color: TWColors.gray.shade700,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: nowPlaying.podcast.title,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.25,
              color: TWColors.gray.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    final actions = Padding(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.playlist_add,
              size: 26,
              color: TWColors.gray.shade700,
            ),
            onPressed: null,
          ),
          Container(width: 6),
          IconButton(
            icon: Icon(
              Icons.save_alt,
              size: 24,
              color: TWColors.gray.shade700,
            ),
            onPressed: null,
          ),
          Container(width: 6),
          IconButton(
            icon: Icon(
              Icons.share,
              size: 20,
              color: TWColors.gray.shade700,
            ),
            onPressed: null,
          ),
          Container(width: 6),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              size: 22,
              color: TWColors.gray.shade700,
            ),
            onPressed: null,
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          episodeTitle,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              artWork,
              Expanded(
                child: Container(
                  height: 115,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            publishDate,
                            Container(height: 6),
                            podcastTitle,
                          ],
                        ),
                      ),
                      actions,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
