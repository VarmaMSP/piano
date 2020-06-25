import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  PodcastHeaderDelegate({
    @required this.podcast,
    @required this.tabController,
  });

  static const double appBarHeight = 55;
  static const double tabBarHeight = 36;
  static const double flexibleAreaHeight = 142;

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
              child: _flexibleArea(context, shrinkOffset),
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
            offset: const Offset(-14, 0),
            child: Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: TWColors.gray.shade800,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: (maxExtent - shrinkOffset - minExtent).abs() < 0.001
                ? 1.0
                : 0.0,
            child: Transform.translate(
              offset: Offset(23, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CachedNetworkImage(
                  imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                  placeholder: (BuildContext context, String url) => Container(
                    height: 35,
                    width: 35,
                    color: TWColors.gray.shade300,
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: SizedBox(
                    width: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 24,
                        color: TWColors.gray.shade800,
                      ),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/search'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: TWColors.gray.shade800,
                      size: 24,
                    ),
                    padding: const EdgeInsets.all(0),
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    offset: Offset(0, 40),
                    itemBuilder: (BuildContext context) {
                      return <String>[
                        'Share',
                      ].map((String t) {
                        return PopupMenuItem<String>(
                          value: t,
                          child: Text(t),
                        );
                      }).toList();
                    },
                    onSelected: (value) {
                      switch (value) {
                        case 'Share':
                          Share.share(
                            'https://phenopod.com/podcasts/${podcast.urlParam}',
                          );
                          return;
                      }
                    },
                  ),
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
        labelPadding: EdgeInsets.symmetric(horizontal: 14),
        labelStyle: TextStyle(
          fontSize: 13.5,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
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
          Tab(text: ' Episodes '),
          Tab(text: ' About '),
        ],
      ),
    );
  }

  Widget _flexibleArea(BuildContext context, double shrinkOffset) {
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
            fontWeight: FontWeight.w500,
            color: TWColors.gray.shade800,
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

    final podcastActionsBloc = Provider.of<PodcastActionsBloc>(context);

    final Widget actions = Container(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 0.65,
              child: FlatButton(
                onPressed: () => podcast.isSubscribed
                    ? podcastActionsBloc.unsubscribe(podcast)
                    : podcastActionsBloc.subscribe(podcast),
                color: podcast.isSubscribed
                    ? TWColors.gray.shade300
                    : TWColors.purple.shade600,
                textColor: podcast.isSubscribed
                    ? TWColors.gray.shade800
                    : TWColors.gray.shade100,
                child: Text(
                  podcast.isSubscribed ? 'SUBSCRIBED' : 'SUBSCRIBE',
                  style: TextStyle(
                    letterSpacing: 0.75,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ],
      ),
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
                height: 120,
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, -4),
                      child: details,
                    ),
                    const Spacer(),
                    actions,
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
