import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/episode_list_item/menu.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import './thumbnail.dart';
import 'package:timeago/timeago.dart' as timeago;

class EpisodeListItem extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = Text(
      episode.title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 15,
        color: TWColors.gray.shade800,
        height: 1.4,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
    );

    final info = RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
          fontSize: 13.5,
          color: TWColors.teal.shade900,
          letterSpacing: 0.4,
        ),
        children: <TextSpan>[
          ..._episodeNumber(episode),
          ..._episodePubDate(episode),
        ],
      ),
    );

    final summary = Text(
      episode.summary
          .replaceAll('\n', ' ')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp', '&'),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12.2,
        color: TWColors.teal.shade700,
        height: 1.35,
        letterSpacing: 0.3,
      ),
      maxLines: 3,
      textAlign: TextAlign.left,
    );

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 4, left: 14, right: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Thumbnail(episode: episode, podcast: podcast),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
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
                                  padding: const EdgeInsets.only(bottom: 4.5),
                                  child: title,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: info,
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(6, -12),
                            child: Menu(),
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
    var d = DateTime.parse('${episode.pubDate} +00:00');
    return [TextSpan(text: timeago.format(d))];
  }

  List<TextSpan> _episodeNumber(Episode episode) {
    if (episode.type == 'FULL' && episode.episode == 0) {
      return [];
    }

    String text;
    Color color;
    if (episode.type == 'BONUS') {
      text = 'BONUS';
      color = TWColors.orange.shade700;
    } else if (episode.type == 'TRAILER') {
      text = 'TRAILER';
      color = TWColors.red.shade700;
    } else if (episode.season > 0) {
      text = 'S${episode.season} E${episode.episode}';
      color = TWColors.teal.shade800;
    } else {
      text = 'E${episode.episode}';
      color = TWColors.teal.shade800;
    }

    return [
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 12.8,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextSpan(
        text: ' · ',
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    ];
  }
}
