import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class QueueList extends StatelessWidget {
  const QueueList({Key key, this.queue}) : super(key: key);

  final Queue queue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 50, left: 6, right: 8),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: queue.audioTracks.map(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(AudioTrack audioTrack) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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
