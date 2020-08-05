// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/request.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  static const double thumbnailSize = 65;

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    final image = CachedNetworkImage(
      imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
      fit: BoxFit.fill,
      height: thumbnailSize,
      width: thumbnailSize,
      placeholder: (BuildContext context, String url) => Container(
        height: thumbnailSize,
        width: thumbnailSize,
        color: TWColors.gray.shade300,
      ),
    );

    final Widget playIconBg = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(600.0),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          height: 28.0,
          width: 28.0,
        ),
      ),
    );

    final Widget playIcon = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 22,
      ),
    );

    final Widget duration = Container(
      alignment: const Alignment(0.85, 0.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: _buildDuration(episode.duration),
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            audioPlayerBloc.addQueueAction(QueueAction.playTrack(
              audioTrack: AudioTrack(
                episode: episode,
                podcast: podcast,
              ),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              border: Border.all(color: Colors.grey.shade400, width: 0.25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: SizedBox(
                height: thumbnailSize,
                width: thumbnailSize,
                child: Stack(
                  children: [
                    image,
                    // playIconBg,
                    // playIcon,
                    // duration,
                  ],
                ),
              ),
            ),
          ),
        ),
        // Container(height: 5),
        // StreamBuilder<PlaybackPosition>(
        //   stream: store.playbackPosition.watchByEpisode(episode.id),
        //   builder: (context, snapshot) {
        //     return _buildProgressbar(snapshot.data);
        //   },
        // ),
      ],
    );
  }

  Widget _buildDuration(int sec) {
    RegExp regex;
    if (sec < 60 * 60) {
      regex = RegExp(r'\d\d:(\d\d:\d\d)');
    } else if (sec < 10 * 60 * 60) {
      regex = RegExp(r'\d(\d:\d\d:\d\d)');
    } else {
      regex = RegExp(r'(\d\d:\d\d:\d\d)');
    }

    final res = regex
        .firstMatch(DateTime(0, 0, 0, 0, 0, sec).toIso8601String())
        ?.group(1);
    if (res == null) {
      return null;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.65),
        padding: const EdgeInsets.only(left: 3, right: 3, top: 1.5, bottom: 0),
        child: Text(
          res ?? '00:00',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProgressbar(PlaybackPosition playback) {
    if (playback == null) {
      return Container(height: 5);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        height: 4,
        width: thumbnailSize,
        color: TWColors.gray.shade400,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          heightFactor: 1.0,
          widthFactor: playback.percentage,
          child: Container(color: TWColors.red.shade600),
        ),
      ),
    );
  }
}
