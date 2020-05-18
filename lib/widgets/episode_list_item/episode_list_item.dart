import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/episode_list_item/menu.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import './thumbnail.dart';

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      episode.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14.45,
        color: const Color(0xff2a303b),
        height: 1.32,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
    );

    final Widget info = RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
          fontSize: 13,
          color: TWColors.gray.shade900,
          letterSpacing: 0.25,
        ),
        children: <TextSpan>[
          ..._episodeNumber(episode),
          ..._episodePubDate(episode),
        ],
      ),
    );

    final Widget summary = Text(
      episode.summary
          .replaceAll('\n', ' ')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp', '&'),
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xff657389), //TWColors.gray.shade600,
        height: 1.3,
        letterSpacing: 0.1,
      ),
      maxLines: 2,
      textAlign: TextAlign.left,
    );

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 13, bottom: 13, left: 14, right: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Thumbnail(episode: episode, podcast: podcast),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -4),
                child: Padding(
                  padding: const EdgeInsets.only(left: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: title,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: info,
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(6, -9),
                            child: const Menu(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: summary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _episodePubDate(Episode episode) {
    final DateTime d = DateTime.parse('${episode.pubDate} +00:00');
    return <TextSpan>[TextSpan(text: timeago.format(d))];
  }

  List<TextSpan> _episodeNumber(Episode episode) {
    if (episode.type == 'FULL' && episode.episode == 0) {
      return <TextSpan>[];
    }

    String text;
    Color color;
    if (episode.type == 'BONUS') {
      text = 'BONUS';
      color = TWColors.orange.shade600;
    } else if (episode.type == 'TRAILER') {
      text = 'TRAILER';
      color = TWColors.red.shade600;
    } else if (episode.season > 0) {
      text = 'S${episode.season} E${episode.episode}';
      color = TWColors.gray.shade700;
    } else {
      text = 'E${episode.episode}';
      color = TWColors.gray.shade700;
    }

    return <TextSpan>[
      TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
      ),
      TextSpan(
        text: '  ·  ',
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    ];
  }
}
