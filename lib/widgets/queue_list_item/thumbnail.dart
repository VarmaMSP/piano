import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key key,
    @required this.podcast,
  }) : super(key: key);

  static const double thumbnailSize = 60;
  static const double borderRadius = 5;

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
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
    );

    return Container(
      height: thumbnailSize,
      width: thumbnailSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: Colors.grey.shade400, width: 0.4),
      ),
      child: Stack(
        children: [image],
      ),
    );
  }
}
