import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/episode_list_item/menu.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
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
    final store = Provider.of<Store>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  episode.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              StreamBuilder<AudioFile>(
                stream: store.audioFile.watchByEpisode(episode.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _episodeInfo(context);
                  }
                  if (snapshot.data.isComplete) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          MdiIcons.checkUnderlineCircle,
                          size: 14,
                          color: TWColors.blue.shade700,
                        ),
                        Container(width: 10),
                        Expanded(child: _episodeInfo(context)),
                      ],
                    );
                  }
                  return _episodeDownloadInfo(context, snapshot.data);
                },
              ),
              Container(height: 6),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(6, -13),
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

  Widget _episodeInfo(BuildContext context) {
    String text;
    if (episode.type == 'FULL' && episode.episode == 0) {
      text = null;
    } else if (episode.type == 'BONUS') {
      text = 'BONUS';
    } else if (episode.type == 'TRAILER') {
      text = 'TRAILER';
    } else if (episode.season > 0) {
      text = 'S${episode.season} E${episode.episode}';
    } else {
      text = 'E${episode.episode}';
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: Colors.grey.shade900),
        children: <TextSpan>[
          // Episode number and type
          if (type == EpisodeListItemType.podcastItem && text != null) ...[
            TextSpan(text: text),
            TextSpan(text: '  ·  '),
          ],
          // Episode pub date
          TextSpan(
            text: timeago
                .format(episode.pubDate)
                .replaceAll(RegExp('about '), ''),
          ),
          // Podcas tytle
          if (type == EpisodeListItemType.subscriptionsItem) ...[
            TextSpan(text: '  ·  '),
            TextSpan(text: podcast.title),
          ]
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _episodeDownloadInfo(BuildContext context, AudioFile audioFile) {
    String text;
    if (audioFile.isDownloading) {
      text = 'Downloading...  ${(audioFile.downloadPercentage * 100).round()}%';
    } else if (audioFile.isDownloading) {
      text = 'Download complete.';
    } else {
      text = 'Waiting to download...';
    }

    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(color: TWColors.blue.shade700),
    );
  }
}
