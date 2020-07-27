// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:html_unescape/html_unescape_small.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:when_expression/when_expression.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_menu.dart';
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
      padding: type == EpisodeListItemType.podcastItem
          ? const EdgeInsets.only(top: 14, bottom: 14, left: 18, right: 4)
          : const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Thumbnail(episode: episode, podcast: podcast),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildDetails(context),
                    Container(
                      transform: Matrix4.translationValues(0, -1, 0),
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        HtmlUnescape()
                            .convert(episode.summary)
                            .replaceAll('\n', ' ')
                            .replaceAll('&amp', '&')
                            .trim(),
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

    return StreamBuilder<EpisodeMeta>(
      stream: store.episode.watchMeta(episode.id),
      builder: (context, snapshot) {
        final subtitle = when<EpisodeMeta, Widget>({
          (m) => m == null: (_) => _episodeInfo(context),
          (_) => true: when<EpisodeMeta, Widget>({
            (m) => m.downloadProgress != null && !m.downloadProgress.isComplete:
                (m) => _episodeDownloadInfo(context, m.downloadProgress),
            (_) => true: (m) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (m.audioTrack != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Icon(
                          Icons.playlist_add_check_rounded,
                          size: 17,
                          color: TWColors.green.shade700,
                        ),
                      ),
                    if (m.audioTrack != null) Container(width: 12),
                    if (m.downloadProgress != null &&
                        m.downloadProgress.isComplete)
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Icon(
                          MdiIcons.checkUnderlineCircle,
                          size: 14,
                          color: TWColors.blue.shade700,
                        ),
                      ),
                    if (m.downloadProgress != null &&
                        m.downloadProgress.isComplete)
                      Container(width: 12),
                    Expanded(child: _episodeInfo(context)),
                  ],
                ),
          }),
        })(snapshot.data);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      episode.title,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  subtitle,
                  Container(height: 4),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(6, -13),
              child: type == EpisodeListItemType.podcastItem
                  ? EpisodeMenu.episodeListItem(
                      episode: episode,
                      podcast: podcast,
                      episodeMeta: snapshot.data,
                    )
                  : EpisodeMenu.subscriptionListItem(
                      episode: episode,
                      podcast: podcast,
                      episodeMeta: snapshot.data,
                    ),
            ),
          ],
        );
      },
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
            .copyWith(fontSize: 12.5, color: Colors.grey.shade900),
        children: <TextSpan>[
          // Episode number and type
          if (type == EpisodeListItemType.podcastItem && text != null) ...[
            TextSpan(
              text: text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 12, color: Colors.grey.shade900),
            ),
            TextSpan(
              text: '  ·  ',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
          // Episode pub date
          TextSpan(text: formatRelativeTime(episode.pubDate)),
          // Podcas tytle
          if (type == EpisodeListItemType.subscriptionsItem) ...[
            TextSpan(
              text: '  ·  ',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            TextSpan(text: podcast.title),
          ]
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _episodeDownloadInfo(
    BuildContext context,
    DownloadProgress downloadProgress,
  ) {
    String text;
    if (downloadProgress.isDownloading) {
      text =
          'Downloading...  ${(downloadProgress.downloadPercentage * 100).round()}%';
    } else if (downloadProgress.isDownloading) {
      text = 'Download complete.';
    } else {
      text = 'Waiting to download...';
    }

    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(fontSize: 12.5, color: TWColors.blue.shade700),
    );
  }
}
