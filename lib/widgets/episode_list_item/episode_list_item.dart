import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/bottom_sheet/episode_details.dart';
import 'package:phenopod/widgets/episode_list_item/menu.dart';
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
        fontSize: 14.2,
        color: TWColors.gray.shade900,
        height: 1.35,
        letterSpacing: 0.2,
        wordSpacing: 0.3,
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
          letterSpacing: 0.2,
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
      style: TextStyle(
        fontSize: 12.1,
        color: Color(0xff657389), //TWColors.gray.shade600,
        height: 1.3,
        letterSpacing: 0.175,
        wordSpacing: 0.1,
      ),
      maxLines: 2,
      textAlign: TextAlign.left,
    );

    return Container(
      padding: const EdgeInsets.only(top: 13, bottom: 18, left: 18, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Thumbnail(episode: episode, podcast: podcast),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -3),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: const EdgeInsets.only(bottom: 4.5),
                                child: info,
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(6, -8),
                          child: Menu(
                            episode: episode,
                            podcast: podcast,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showEpisodeDetailsBottomSheet(
                          context: context,
                          episode: episode,
                          podcast: podcast,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: summary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _episodePubDate(Episode episode) {
    final dateTime = DateTime.parse('${episode.pubDate} +00:00');
    return <TextSpan>[TextSpan(text: timeago.format(dateTime))];
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
          letterSpacing: 0.3,
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
