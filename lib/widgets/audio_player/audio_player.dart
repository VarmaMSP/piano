import 'package:flutter/material.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/audio_player/widgets/playback_controls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phenopod/widgets/audio_player/widgets/seek_bar.dart';
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
        top: 10,
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          '$thumbnailUrl/${nowPlaying.podcast.urlParam}.jpg',
                      fit: BoxFit.fill,
                      placeholder: (BuildContext context, String url) =>
                          Container(
                        constraints: BoxConstraints.expand(),
                        color: TWColors.gray.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: SeekBar(),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              nowPlaying.episode.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: TWColors.gray.shade800,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
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
                  fontSize: 16,
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
