import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/foundation.dart';

class PodcastAppBar extends StatelessWidget {
  const PodcastAppBar({
    Key key,
    @required this.podcast,
    @required this.tabController,
  }) : super(key: key);

  final Podcast podcast;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: _PodcastHeaderDelegate(
        podcast: podcast,
        tabController: tabController,
      ),
    );
  }
}

class _PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  static final double appBarHeight = 55;
  static final double tabBarHeight = 40;
  static final double flexibleAreaHeight = 150;

  _PodcastHeaderDelegate({
    @required this.podcast,
    @required this.tabController,
  });

  final Podcast podcast;
  final TabController tabController;
  final double minExtent = appBarHeight + tabBarHeight + 1;
  final double maxExtent = appBarHeight + tabBarHeight + flexibleAreaHeight + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    log('$overlapsContent - $shrinkOffset');

    return Container(
      height: maxExtent - shrinkOffset,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: overlapsContent ? Colors.black : Colors.white,
        border: Border(
          bottom: BorderSide(color: TWColors.gray.shade400),
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _appBar(shrinkOffset),
          if (shrinkOffset < flexibleAreaHeight) _flexibleArea(shrinkOffset),
          _tabBar(shrinkOffset),
        ],
      ),
    );
  }

  Widget _appBar(double shrinkOffset) {
    return Container(
      height: appBarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.arrow_back, size: 24, color: TWColors.gray.shade800),
          if ((shrinkOffset - flexibleAreaHeight).abs() < 0.0001)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add, size: 24, color: TWColors.gray.shade800),
                Container(
                  width: 20,
                ),
                Icon(Icons.share, size: 22, color: TWColors.gray.shade800),
              ],
            ),
        ],
      ),
    );
  }

  Widget _tabBar(double shrinkOffset) {
    return Container(
      height: tabBarHeight,
      alignment: Alignment.bottomLeft,
      transform: Matrix4.translationValues(
          -15, appBarHeight + flexibleAreaHeight - shrinkOffset, 0),
      child: TabBar(
        isScrollable: true,
        indicatorColor: TWColors.green.shade900,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2.8,
        labelColor: TWColors.teal.shade900,
        labelStyle: TextStyle(
          fontSize: 15,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w600,
        ),
        controller: tabController,
        tabs: <Widget>[
          Tab(text: '  Episodes  '),
          Tab(text: '  About  '),
        ],
      ),
    );
  }

  Widget _flexibleArea(double shrinkOffset) {
    final thumbnail = ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: 130,
        width: 130,
      ),
    );

    final title = Text(
      podcast.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 1.35,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: TWColors.gray.shade900,
        letterSpacing: 0.25,
      ),
    );

    final author = Text(
      podcast.author,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 1.35,
        fontSize: 14,
        color: TWColors.gray.shade900,
        letterSpacing: 0.25,
      ),
    );

    return Container(
      height: flexibleAreaHeight,
      padding: EdgeInsets.only(top: 8),
      transform: Matrix4.translationValues(0, appBarHeight - shrinkOffset, 0),
      child: Opacity(
        opacity: 1.0 - shrinkOffset / flexibleAreaHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            thumbnail,
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 14),
                transform: Matrix4.translationValues(0, -4, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    Container(height: 6),
                    author,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
