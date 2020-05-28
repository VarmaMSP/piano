import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/link.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class TrendingPodcasts extends StatefulWidget {
  const TrendingPodcasts({
    Key key,
    @required this.trending,
  }) : super(key: key);

  final List<Podcast> trending;

  @override
  _TrendingPodcastsState createState() => _TrendingPodcastsState();
}

class _TrendingPodcastsState extends State<TrendingPodcasts> {
  double _currentPage;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 24,
        bottom: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Trending',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Container(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 228,
                width: (getScreenWidth(context) - 52.0),
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  children: _buildPages(),
                ),
              ),
              DotsIndicator(
                dotsCount: 4,
                position: _currentPage,
                axis: Axis.vertical,
                decorator: DotsDecorator(
                    spacing: const EdgeInsets.all(5.0),
                    color: TWColors.gray.shade300,
                    activeColor: TWColors.gray.shade600,
                    size: const Size.square(6.0),
                    activeSize: const Size.square(6.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPages() {
    var chunks = <List<Podcast>>[];
    for (var i = 0; i < widget.trending.length; i += 4) {
      chunks.add(widget.trending.sublist(i, i + 4));
    }

    return chunks
        .map((chunk) => Column(
              mainAxisSize: MainAxisSize.min,
              children: chunk.map(_buildPageItem).toList(),
            ))
        .toList();
  }

  Widget _buildPageItem(Podcast podcast) {
    return PodcastLink(
      podcast: podcast,
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PodcastThumbnail(
              podcast: podcast,
              size: PodcastThumbnailSize.xs,
            ),
            Container(width: 10),
            Expanded(
              child: Text(
                podcast.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
