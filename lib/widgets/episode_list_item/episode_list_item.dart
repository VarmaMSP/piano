import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/download_progress_indicator.dart';
import 'package:phenopod/widgets/episode_list_item/menu.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'thumbnail.dart';

enum EpisodeListItemType {
  podcastItem,
  subscriptionsItem,
}

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
    @required this.type,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;
  final EpisodeListItemType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 13, bottom: 18, left: 18, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Thumbnail(episode: episode, podcast: podcast),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -1),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildDetails(context),
                    Container(
                      transform: Matrix4.translationValues(0, -2, 0),
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        episode.summary
                            .replaceAll('\n', ' ')
                            .replaceAll('&nbsp;', ' ')
                            .replaceAll('&amp', '&'),
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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

  Widget _buildDetails(BuildContext context) {
    final Widget title = Text(
      episode.title,
      style: Theme.of(context).textTheme.headline6,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    final Widget info = RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1,
        children: <TextSpan>[
          if (type == EpisodeListItemType.podcastItem) ..._episodeNumber(),
          ..._episodePubDate(),
          if (type == EpisodeListItemType.subscriptionsItem) ...[
            TextSpan(
              text: '  ·  ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            TextSpan(text: podcast.title),
          ]
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: title,
              ),
              Row(
                children: <Widget>[
                  DownloadProgressIndicator(episodeId: episode.id),
                  Expanded(child: info)
                ],
              ),
              Container(height: 6),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(6, -14),
          child: Menu(
            episode: episode,
            podcast: podcast,
            options: [
              EpisodeOption.playNext,
              EpisodeOption.addToQueue,
              if (type == EpisodeListItemType.subscriptionsItem)
                EpisodeOption.goToPodcast,
              EpisodeOption.download,
            ],
          ),
        ),
      ],
    );
  }

  List<TextSpan> _episodePubDate() {
    final dateTime = DateTime.parse('${episode.pubDate} +00:00');
    return <TextSpan>[TextSpan(text: timeago.format(dateTime))];
  }

  List<TextSpan> _episodeNumber() {
    if (episode.type == 'FULL' && episode.episode == 0) {
      return <TextSpan>[];
    }

    String text;
    if (episode.type == 'BONUS') {
      text = 'BONUS';
    } else if (episode.type == 'TRAILER') {
      text = 'TRAILER';
    } else if (episode.season > 0) {
      text = 'S${episode.season} E${episode.episode}';
    } else {
      text = 'E${episode.episode}';
    }

    return <TextSpan>[
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 11.5,
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
