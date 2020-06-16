import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/link.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Trending extends StatelessWidget {
  const Trending({Key key, @required this.trending}) : super(key: key);

  final List<Podcast> trending;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                top: 20.0,
                bottom: 15.0,
              ),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  color: TWColors.gray.shade800,
                ),
              ),
            ),
            Container(
              height: 310,
              padding: const EdgeInsets.only(
                bottom: 25.0,
              ),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  childAspectRatio: 80.0 / 96.0,
                ),
                itemBuilder: (context, index) {
                  return PodcastLink(
                    podcast: trending[index],
                    child: Container(
                      padding: EdgeInsets.only(left: 18.0),
                      child: PodcastThumbnail(
                        podcast: trending[index],
                        size: PodcastThumbnailSize.md,
                      ),
                    ),
                  );
                },
                itemCount: trending.length,
              ),
            )
          ]),
    );
  }
}
