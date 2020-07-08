import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/services.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<Queue>(
        stream: audioPlayerBloc.queue,
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildAppBar(context),
              if (snapshot.hasData)
                Expanded(
                  child: _buildList(
                    context,
                    audioPlayerBloc,
                    snapshot.data.audioTracks ?? [],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade500, blurRadius: 2),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(6, 0),
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: TWColors.gray.shade700,
                    ),
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                  ),
                ),
                Container(width: 8),
                Text(
                  'Queue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AudioPlayerBloc audioPlayerBloc,
    List<AudioTrack> tracks,
  ) {
    return ImplicitlyAnimatedReorderableList<AudioTrack>(
      items: tracks,
      areItemsTheSame: (a, b) => a.episode.id == b.episode.id,
      onReorderFinished: (item, from, to, newItems) {
        audioPlayerBloc.transistionQueue(
          QueueTransistion.changeTrackPosition(from: from, to: to),
        );
      },
      itemBuilder: (context, itemAnimation, item, index) {
        return Reorderable(
          key: ValueKey(item.episode.id),
          builder: (context, dragAnimation, inDrag) {
            final t = dragAnimation.value;

            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: itemAnimation,
              child: Material(
                color: Color.lerp(
                  Colors.white,
                  Colors.white.withOpacity(0.8),
                  t,
                ),
                elevation: lerpDouble(0, 8, t),
                type: MaterialType.transparency,
                child: _buildListItem(item),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListItem(AudioTrack audioTrack) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.unfold_more,
            color: TWColors.gray.shade700,
            size: 22,
          ),
          Container(width: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: CachedNetworkImage(
              imageUrl: '$thumbnailUrl/${audioTrack.podcast.urlParam}.jpg',
              fit: BoxFit.fill,
              height: 55,
              width: 55,
              placeholder: (BuildContext context, String url) => Container(
                height: 55,
                width: 55,
                color: TWColors.gray.shade300,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    audioTrack.episode.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      color: TWColors.gray.shade800,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.25,
                      height: 1.2,
                    ),
                  ),
                  Container(height: 4),
                  Text(
                    '${formatDuration(seconds: audioTrack.episode.duration)}',
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.15,
                    ),
                  )
                ],
              ),
            ),
          ),
          Icon(
            Icons.more_vert,
            color: TWColors.gray.shade600,
            size: 22,
          ),
        ],
      ),
    );
  }
}
