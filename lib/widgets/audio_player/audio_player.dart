import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:phenopod/widgets/audio_player/widgets/description.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    Key key,
    @required this.animations,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
    @required this.onSeek,
  }) : super(key: key);

  final BottomAppBarAnimations animations;
  final AudioPlayerActive state;
  final void Function() onPlay;
  final void Function() onPause;
  final void Function(int) onSeek;

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animations.playerBackgroundColor,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 14, right: 14),
              color: widget.animations.playerBackgroundColor.value,
              child: Column(
                children: <Widget>[
                  _buildDetails(),
                  Container(height: 24),
                  _seekBar(),
                  Container(height: 20),
                  _buildPlaybackControls(),
                  Container(height: 20),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 24,
                        left: 14,
                        right: 14,
                        bottom: 48,
                      ),
                      child: Description(),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetails() {
    final episodeTitle = Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: 22),
      child: Text(
        widget.state.playingNow.episode.title,
        style: TextStyle(
          fontSize: 18,
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
      borderRadius: BorderRadius.circular(4.0),
      child: CachedNetworkImage(
        imageUrl:
            'https://cdn.phenopod.com/thumbnails/${widget.state.playingNow.podcast.urlParam}.jpg',
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
            text: widget.state.playingNow.podcast.title,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.25,
              color: TWColors.gray.shade700,
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
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          episodeTitle,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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

  Widget _seekBar() {
    double _tmpSeekPosition;

    return StreamBuilder<double>(
      stream: Rx.combineLatest2<double, double, double>(
        Stream.periodic(Duration(milliseconds: 200)),
        _dragPositionSubject.stream,
        (_, x) => x,
      ),
      builder: (context, snapshot) {
        var duration = widget.state.audioState.duration?.toDouble() ?? 0.0;
        var currentTime = _tmpSeekPosition ??
            snapshot.data ??
            widget.state.audioState.currentTime?.toDouble() ??
            0.0;
        currentTime = max(0.0, min(currentTime, duration));

        var parsedDurations =
            _parseDuration(currentTime.toInt(), duration.toInt());

        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              parsedDurations[0],
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.2,
                color: TWColors.gray.shade800,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackHeight: 2.5,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
                  inactiveTickMarkColor: Colors.red[100],
                ),
                child: Slider(
                  min: 0.0,
                  max: duration,
                  value: currentTime,
                  onChanged: (value) {
                    _dragPositionSubject.add(value);
                  },
                  onChangeEnd: (value) {
                    _tmpSeekPosition = value.toInt().toDouble();
                    widget.onSeek(value.toInt());
                    _dragPositionSubject.add(null);
                  },
                ),
              ),
            ),
            Text(
              parsedDurations[1],
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.2,
                color: TWColors.gray.shade800,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaybackControls() {
    final actionButton = Container(
      height: 64,
      width: 64,
      child: Stack(
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TWColors.purple.shade600,
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: TWColors.gray.shade300,
              //     blurRadius: 1,
              //     spreadRadius: 2,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(900),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: _buildActionButton(),
          ),
        ],
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.skip_previous, size: 32),
        ),
        Container(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.fast_rewind, size: 32),
        ),
        actionButton,
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.fast_forward, size: 32),
        ),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.skip_next, size: 32),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    IconData iconData;
    void Function() onPressed;
    if (widget.state.audioState.isPlaying) {
      iconData = Icons.pause;
      onPressed = () => widget.onPause();
    } else if (widget.state.audioState.isPaused) {
      iconData = Icons.play_arrow;
      onPressed = () => widget.onPlay();
    } else {
      iconData = Icons.play_arrow;
      onPressed = () {};
    }

    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          iconData,
          color: TWColors.gray.shade100,
          size: 36,
        ),
        onPressed: onPressed,
      ),
    );
  }

  List<String> _parseDuration(int currentTime, int duration) {
    RegExp regex;
    if (duration < 60 * 60 * 1000) {
      regex = RegExp(r'\d\d:(\d\d:\d\d)');
    } else if (duration < 10 * 60 * 60 * 1000) {
      regex = RegExp(r'\d(\d:\d\d:\d\d)');
    } else {
      regex = RegExp(r'(\d\d:\d\d:\d\d)');
    }

    return <String>[
      regex
          .firstMatch(DateTime(0, 0, 0, 0, 0, 0, currentTime).toIso8601String())
          ?.group(1),
      regex
          .firstMatch(DateTime(0, 0, 0, 0, 0, 0, duration).toIso8601String())
          ?.group(1)
    ];
  }
}
