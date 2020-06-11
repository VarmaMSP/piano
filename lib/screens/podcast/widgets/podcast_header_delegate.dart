import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:phenopod/utils/request.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  PodcastHeaderDelegate({
    @required this.podcast,
    @required this.tabController,
  });

  static const double appBarHeight = 45;
  static const double tabBarHeight = 36;
  static const double flexibleAreaHeight = 135;

  final Podcast podcast;
  final TabController tabController;

  @override
  final double minExtent = appBarHeight + tabBarHeight;
  @override
  final double maxExtent = appBarHeight + tabBarHeight + flexibleAreaHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent - shrinkOffset,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if ((maxExtent - shrinkOffset - minExtent).abs() <= 0.001)
            BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)
        ],
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: _appBar(context, shrinkOffset),
          ),
          if ((maxExtent - shrinkOffset - minExtent).abs() > 0.001)
            Positioned(
              bottom: tabBarHeight,
              left: 0.0,
              right: 0.0,
              child: _flexibleArea(shrinkOffset),
            ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: _tabBar(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context, double shrinkOffset) {
    return Container(
      height: appBarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(-16, 0),
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
          Transform.translate(
            offset: const Offset(20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 23,
                    color: TWColors.gray.shade700,
                  ),
                  onPressed: null,
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
      transform: Matrix4.translationValues(-14, 0, 0),
      child: TabBar(
        isScrollable: true,
        indicatorColor: TWColors.yellow.shade400,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.5,
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 13.5,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        unselectedLabelColor: TWColors.gray.shade500,
        unselectedLabelStyle: TextStyle(
          fontSize: 13.5,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
        ),
        controller: tabController,
        tabs: const <Widget>[
          Tab(text: '  Episodes  '),
          Tab(text: '  About  '),
        ],
      ),
    );
  }

  Widget _flexibleArea(double shrinkOffset) {
    final Widget thumbnail = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: 120,
        width: 120,
        placeholder: (BuildContext context, String url) => Container(
          height: 120,
          width: 120,
          color: TWColors.gray.shade300,
        ),
      ),
    );

    final Widget details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          podcast.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            height: 1.4,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            letterSpacing: 0.2,
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

    final Widget actions = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.add,
        //     size: 26,
        //     color: TWColors.gray.shade700,
        //   ),
        //   onPressed: null,
        // ),
        // Container(width: 10),
        // IconButton(
        //   icon: Icon(
        //     Icons.share,
        //     size: 22,
        //     color: TWColors.gray.shade700,
        //   ),
        //   onPressed: null,
        // ),
      ],
    );

    final opacity = 1.0 - shrinkOffset / (flexibleAreaHeight - 10.0);

    return Opacity(
      opacity: opacity >= 0.0 ? opacity : 0.0,
      child: Container(
        height: flexibleAreaHeight,
        padding: const EdgeInsets.only(top: 8),
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
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(6, 0),
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
