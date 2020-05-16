import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  static final double appBarHeight = 45;
  static final double tabBarHeight = 35;
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
          _appBar(context, shrinkOffset),
          _flexibleArea(shrinkOffset),
          _tabBar(shrinkOffset),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context, double shrinkOffset) {
    final actions = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if ((shrinkOffset - flexibleAreaHeight).abs() < 0.0001)
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              size: 23,
              color: TWColors.gray.shade700,
            ),
            onPressed: null,
          ),
        Container(width: 2),
        IconButton(
          icon: Icon(
            Icons.search,
            size: 23,
            color: TWColors.gray.shade700,
          ),
          onPressed: null,
        ),
      ],
    );

    return Container(
      height: appBarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(-12, 0),
            child: Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 23,
                  color: TWColors.gray.shade700,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Container(
            child: Transform.translate(
              offset: Offset(10, 0),
              child: actions,
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
        indicatorWeight: 2.4,
        labelColor: TWColors.gray.shade700,
        labelStyle: TextStyle(
          fontSize: 13.5,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
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
      borderRadius: BorderRadius.circular(6.0),
      child: CachedNetworkImage(
        imageUrl: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: 130,
        width: 130,
        placeholder: (context, url) => Container(
          height: 130,
          width: 130,
          color: TWColors.gray.shade300,
        ),
      ),
    );

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          podcast.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            height: 1.4,
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
            color: TWColors.gray.shade800,
            letterSpacing: 0.4,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            size: 26,
            color: TWColors.gray.shade700,
          ),
          onPressed: null,
        ),
        Container(width: 10),
        IconButton(
          icon: Icon(
            Icons.share,
            size: 22,
            color: TWColors.gray.shade700,
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
                    Transform.translate(
                      offset: Offset(6, 0),
                      child: actions,
                    ),
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
