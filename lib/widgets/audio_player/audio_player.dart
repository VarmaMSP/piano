import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/audio_player/widgets/playback_controls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import '../html.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({
    Key key,
    @required this.animations,
    @required this.tabController,
    @required this.nowPlaying,
  }) : super(key: key);

  final BottomAppBarAnimation animations;
  final TabController tabController;
  final AudioTrack nowPlaying;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        _buildNowPlayingTab(),
        _buildNotesTab(),
      ],
    );
  }

  Widget _buildNowPlayingTab() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: '$thumbnailUrl/${nowPlaying.podcast.urlParam}.jpg',
              fit: BoxFit.fill,
              height: 250,
              width: 250,
              placeholder: (BuildContext context, String url) => Container(
                height: 200,
                width: 200,
                color: TWColors.gray.shade300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35, bottom: 17.5),
            alignment: Alignment.topCenter,
            child: Text(
              nowPlaying.episode.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: TWColors.gray.shade900,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 17.5, bottom: 30),
            alignment: Alignment.topCenter,
            child: Text(
              nowPlaying.podcast.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.3,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.17,
                color: TWColors.gray.shade700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PlaybackControls(),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                top: 25.0,
                bottom: 5.0,
                left: 8.0,
                right: 8.0,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'Published on ${formatDateTime(nowPlaying.episode.pubDate)}',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.25,
                  color: TWColors.gray.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            HTML(
              id: nowPlaying.episode.id,
              document: nowPlaying.episode.description,
            ),
          ],
        ),
      ),
    );
  }
}
