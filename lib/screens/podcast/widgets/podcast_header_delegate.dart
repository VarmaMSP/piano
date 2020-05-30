import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  PodcastHeaderDelegate({
    @required this.podcast,
    @required this.tabController,
  });

  static const double appBarHeight = 45;
  static const double tabBarHeight = 36;
  static const double flexibleAreaHeight = 150;

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
          _appBar(context, shrinkOffset),
          _flexibleArea(shrinkOffset),
          _tabBar(shrinkOffset),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context, double shrinkOffset) {
    final Widget actions = Row(
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
            offset: const Offset(-12, 0),
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
              offset: const Offset(16, 0),
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
          -14, appBarHeight + flexibleAreaHeight - shrinkOffset, 0),
      child: TabBar(
        isScrollable: true,
        indicatorColor: TWColors.yellow.shade400,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 4,
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        unselectedLabelColor: TWColors.gray.shade500,
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
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
        imageUrl: 'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: 130,
        width: 130,
        placeholder: (BuildContext context, String url) => Container(
          height: 130,
          width: 130,
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
            fontWeight: FontWeight.w500,
            color: Colors.black87,
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

    final Widget widget = Container(
      constraints: const BoxConstraints.expand(height: flexibleAreaHeight),
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
    );

    return Transform.translate(
      offset: Offset(0, appBarHeight - shrinkOffset),
      child: Opacity(
        opacity: 1.0 - shrinkOffset / flexibleAreaHeight,
        child: widget,
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
