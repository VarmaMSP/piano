// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_menu.dart';
import 'widgets/playback_control.dart';

enum EpisodeListItemType {
  podcastItem,
  subscriptionsItem,
}

class EpisodeListItem extends StatefulWidget {
  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
    @required this.type,
  }) : super(key: key);

  static const thumbnailSize = 65.0;

  final Episode episode;
  final Podcast podcast;
  final EpisodeListItemType type;

  @override
  _EpisodeListItemState createState() => _EpisodeListItemState();
}

class _EpisodeListItemState extends State<EpisodeListItem> {
  bool _highlight = false;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildThumbnail(context),
            Expanded(
              child: Container(
                height: EpisodeListItem.thumbnailSize,
                padding: const EdgeInsets.only(left: 12.0, right: 16.0),
                child: _buildInfo(context),
              ),
            ),
            Container(width: 10),
            Container(
              height: EpisodeListItem.thumbnailSize,
              child: PlaybackControl(
                episode: widget.episode,
                podcast: widget.podcast,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildEpisodeDescription(context)),
              Container(width: 8.0),
              _buildMenu(context),
            ],
          ),
        ),
      ],
    );

    final setHighlight = (bool highlight) {
      return ([dynamic _]) => Future.delayed(
            highlight ? Duration.zero : Duration(milliseconds: 200),
            () => setState(() {
              _highlight = highlight;
            }),
          );
    };

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      // Highlight
      onTapDown: setHighlight(true),
      onLongPressStart: setHighlight(true),
      onSecondaryTapDown: setHighlight(true),

      // Remove Highlight
      onTapUp: setHighlight(false),
      onTapCancel: setHighlight(false),
      onLongPressEnd: setHighlight(false),
      onSecondaryTapUp: setHighlight(false),
      onSecondaryTapCancel: setHighlight(false),
      onSecondaryLongPressEnd: setHighlight(false),
      // Take Action
      onTap: () => Future.delayed(Duration(milliseconds: 200), () {
        Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
          AppScreen.episodeScreen(urlParam: widget.episode.urlParam),
        );
      }),
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        padding: EdgeInsets.only(top: 16, right: 8, bottom: 14, left: 12),
        decoration: BoxDecoration(
          color: _highlight ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        duration: Duration(milliseconds: 100),
        child: content,
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return StreamBuilder<EpisodeMeta>(
      stream: Provider.of<Store>(context).episode.watchMeta(widget.episode.id),
      builder: (context, snapshot) {
        return widget.type == EpisodeListItemType.podcastItem
            ? EpisodeMenu.episodeListItem(
                episode: widget.episode,
                podcast: widget.podcast,
                episodeMeta: snapshot.data,
              )
            : EpisodeMenu.subscriptionListItem(
                episode: widget.episode,
                podcast: widget.podcast,
                episodeMeta: snapshot.data,
              );
      },
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        border: Border.all(color: Colors.grey.shade500, width: 0.4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        child: CachedNetworkImage(
          imageUrl: '$thumbnailUrl/${widget.podcast.urlParam}.jpg',
          fit: BoxFit.fill,
          height: EpisodeListItem.thumbnailSize,
          width: EpisodeListItem.thumbnailSize,
          placeholder: (BuildContext context, String url) => Container(
            height: EpisodeListItem.thumbnailSize,
            width: EpisodeListItem.thumbnailSize,
            color: TWColors.gray.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return StreamBuilder<EpisodeMeta>(
      stream: Provider.of<Store>(context).episode.watchMeta(widget.episode.id),
      builder: (context, snapshot) {
        final progress = snapshot.data?.downloadProgress;

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -4),
              child: Text(
                widget.episode.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                      color: TWColors.gray.shade900,
                    ),
              ),
            ),
            Container(height: 0),
            if (progress != null && !progress.isComplete)
              _buildEpisodeDownloadInfo(context, progress)
            else
              _buildEpisodeInfo(context),
          ],
        );
      },
    );
  }

  Widget _buildEpisodeDownloadInfo(
    BuildContext context,
    DownloadProgress downloadProgress,
  ) {
    return Text(
      downloadProgress.isDownloading
          ? 'Downloading...  ${(downloadProgress.downloadPercentage * 100).round()}%'
          : 'Waiting to download...',
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 12.5,
            color: TWColors.blue.shade700,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  Widget _buildEpisodeInfo(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontSize: 13,
              color: TWColors.gray.shade900,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
        children: <TextSpan>[
          TextSpan(text: formatRelativeTime(widget.episode.pubDate)),
          if (widget.type == EpisodeListItemType.subscriptionsItem) ...[
            TextSpan(
              text: ' · ',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            TextSpan(text: widget.podcast.title),
          ]
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEpisodeDescription(BuildContext context) {
    return Text(
      HtmlUnescape()
          .convert(widget.episode.summary)
          .replaceAll('\n', ' ')
          .replaceAll('&amp', '&')
          .trim(),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 12.5,
            color: TWColors.gray.shade900,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
