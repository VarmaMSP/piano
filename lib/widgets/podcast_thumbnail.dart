import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum PodcastThumbnailSize { xs, sm, md }

class PodcastThumbnail extends StatelessWidget {
  const PodcastThumbnail({
    Key key,
    @required this.podcast,
    this.size = PodcastThumbnailSize.md,
  }) : super(key: key);

  final Podcast podcast;
  final PodcastThumbnailSize size;

  @override
  Widget build(BuildContext context) {
    var thumbnailSize = 90.0;
    var borderRadius = 10.0;
    if (size == PodcastThumbnailSize.xs) {
      thumbnailSize = 36.0;
      borderRadius = 4.0;
    } else if (size == PodcastThumbnailSize.sm) {
      thumbnailSize = 80.0;
      borderRadius = 10.0;
    }

    return Container(
      height: thumbnailSize,
      width: thumbnailSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
          fit: BoxFit.fill,
          height: thumbnailSize,
          width: thumbnailSize,
          placeholder: (BuildContext context, String url) => Container(
            height: thumbnailSize,
            width: thumbnailSize,
            color: TWColors.gray.shade300,
          ),
        ),
      ),
    );
  }
}
