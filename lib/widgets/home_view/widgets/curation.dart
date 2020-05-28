import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/models/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CurationView extends StatelessWidget {
  const CurationView({
    Key key,
    @required this.curation,
  }) : super(key: key);

  final Curation curation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 18, right: 18),
            alignment: Alignment.centerLeft,
            child: Text(
              curation.title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Container(height: 16),
          Container(
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildPodcastThumbnail(
                  context,
                  curation.podcasts[index],
                  95,
                  isFirst: index == 0,
                  isLast: index == curation.podcasts.length - 1,
                );
              },
              itemCount: curation.podcasts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcastThumbnail(
    BuildContext context,
    Podcast podcast,
    double size, {
    bool isFirst,
    bool isLast,
  }) {
    final imageUrl =
        'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg';

    var padding = EdgeInsets.zero;
    if (isFirst) {
      padding = EdgeInsets.only(left: 18, right: 5);
    } else if (isLast) {
      padding = EdgeInsets.only(left: 5, right: 18);
    } else {
      padding = EdgeInsets.only(left: 5, right: 5);
    }

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/podcast',
            arguments: {'urlParam': podcast.urlParam},
          );
        },
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(color: TWColors.gray.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              placeholder: (BuildContext context, String url) => Container(
                height: size,
                width: size,
                color: TWColors.gray.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
