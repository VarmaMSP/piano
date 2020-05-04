import 'package:flutter/widgets.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:transparent_image/transparent_image.dart';

class PodcastHeader extends StatelessWidget {
  final Podcast podcast;

  const PodcastHeader({
    Key key,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumbnail = ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
        height: 100.0,
        width: 100.0,
      ),
    );

    final title = Text(
      podcast.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 1.35,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: TWColors.gray.shade900,
        letterSpacing: 0.4,
      ),
    );

    final author = Text(
      podcast.author,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 1.35,
        fontSize: 14,
        color: TWColors.gray.shade900,
        letterSpacing: 0.4,
      ),
    );

    final description = Text(
      podcast.description,
      style: TextStyle(
        height: 1.4,
        fontSize: 14,
        color: TWColors.gray.shade800,
        letterSpacing: 0.3,
      ),
    );

    return Container(
      padding: EdgeInsets.only(top: 8, right: 12, bottom: 10, left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              thumbnail,
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: author,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: description,
          ),
          Text(
            'Episodes',
            style: TextStyle(
              height: 1.35,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: TWColors.gray.shade800,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
