import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  static final double appBarHeight = 55;
  static final double tabBarHeight = 40;
  static final double flexibleAreaHeight = 150;

  PodcastHeaderDelegate({
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
    return Container(
      height: maxExtent - shrinkOffset,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: TWColors.gray.shade400),
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _appBar(shrinkOffset),
          _flexibleArea(shrinkOffset),
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
          Text('${appBarHeight - shrinkOffset}'),
          if ((shrinkOffset - flexibleAreaHeight).abs() < 0.0001)
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_box,
                      size: 24,
                      color: TWColors.gray.shade800,
                    ),
                    onPressed: null,
                  ),
                  Container(width: 4),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 24,
                      color: TWColors.gray.shade800,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
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

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          podcast.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            height: 1.35,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: TWColors.gray.shade800,
            letterSpacing: 0.25,
          ),
        ),
        Container(height: 6),
        Text(
          podcast.author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            height: 1.35,
            fontSize: 14,
            color: TWColors.gray.shade900,
            letterSpacing: 0.25,
          ),
        ),
      ],
    );

    final actions = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_box,
            size: 24,
            color: TWColors.gray.shade800,
          ),
          onPressed: null,
        ),
        Container(width: 6),
        IconButton(
          icon: Icon(
            Icons.share,
            size: 24,
            color: TWColors.gray.shade800,
          ),
          onPressed: null,
        ),
      ],
    );

    var widget = Container(
      height: flexibleAreaHeight,
      padding: EdgeInsets.only(top: 8),
      child: Opacity(
        opacity: 1.0 - shrinkOffset / flexibleAreaHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            thumbnail,
            Expanded(
              child: Container(
                height: flexibleAreaHeight,
                padding: const EdgeInsets.only(left: 14),
                transform: Matrix4.translationValues(0, -4, 0),
                child: Column(
                  children: <Widget>[
                    details,
                    Spacer(),
                    actions,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    final offset = appBarHeight - shrinkOffset;

    return Transform.translate(
      offset: Offset(0, offset),
      child: widget,
      // child: offset >= 0
      //     ? widget
      //     : ClipRect(
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           heightFactor:
      //               (flexibleAreaHeight - offset) / flexibleAreaHeight,
      //           child: widget,
      //         ),
      //       ),
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
