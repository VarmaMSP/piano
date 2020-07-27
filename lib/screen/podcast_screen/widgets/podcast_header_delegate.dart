// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animation/podcast_screen_animation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  PodcastHeaderDelegate({
    @required this.tabController,
    @required this.urlParam,
    @required this.title,
    @required this.author,
    this.isSubscribed = false,
    @required this.screenData,
    @required this.animation,
    @required this.forceElevated,
    @required this.scrollToTop,
  });

  static const double appBarHeight = 60;
  static const double tabBarHeight = 35;
  static const double flexibleAreaHeight = 145;

  final TabController tabController;
  final String urlParam;
  final String title;
  final String author;
  final bool isSubscribed;
  final PodcastScreenData screenData;
  final PodcastScreenAnimation animation;
  final bool forceElevated;
  final Function scrollToTop;

  @override
  double get minExtent => appBarHeight + tabBarHeight;

  @override
  double get maxExtent => appBarHeight + tabBarHeight + flexibleAreaHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    animation.aniamteTo(shrinkOffset, maxExtent, minExtent);

    return Container(
      height: maxExtent - shrinkOffset,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (forceElevated)
            BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)
        ],
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          if (!animation.ended && (screenData != null || title != null))
            Positioned(
              bottom: tabBarHeight,
              left: 0.0,
              right: 0.0,
              child: _flexibleArea(context),
            ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: _appBar(context),
          ),
          if (screenData != null)
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: _tabBar(context),
            ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      height: appBarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(-15, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 24,
                color: TWColors.gray.shade700,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (screenData != null && animation.started)
            Expanded(
              child: GestureDetector(
                onTap: scrollToTop,
                behavior: HitTestBehavior.translucent,
                child: FadeTransition(
                  opacity: animation.appBarTitleOpacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 2, right: 40),
                        transform: Matrix4.translationValues(-12, 0, 0),
                        child: Text(
                          screenData.podcast.title,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: TWColors.gray.shade800,
                                fontSize: 16,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Transform.translate(
            offset: const Offset(20, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 24,
                    color: TWColors.gray.shade700,
                  ),
                  visualDensity: VisualDensity.comfortable,
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/search'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 24,
                    color: TWColors.gray.shade700,
                  ),
                  visualDensity: VisualDensity.comfortable,
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/search'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Container(
      height: tabBarHeight,
      alignment: Alignment.bottomLeft,
      transform: Matrix4.translationValues(-14, 0, 0),
      child: TabBar(
        isScrollable: true,
        indicator: MD2Indicator(
          indicatorHeight: 4,
          indicatorColor: Color(0xffffbe0b),
          indicatorSize: MD2IndicatorSize.full,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.grey.shade900,
        labelStyle: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontSize: 13, letterSpacing: 0.4),
        unselectedLabelColor: TWColors.gray.shade500,
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontSize: 13, letterSpacing: 0.4),
        labelPadding: EdgeInsets.only(left: 14, right: 14, bottom: 6),
        controller: tabController,
        tabs: const <Widget>[
          Tab(text: ' Episodes '),
          Tab(text: ' About '),
        ],
      ),
    );
  }

  Widget _flexibleArea(BuildContext context) {
    final Widget thumbnail = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          imageUrl:
              '$thumbnailUrl/${screenData?.podcast?.urlParam ?? urlParam}.jpg',
          fit: BoxFit.fill,
          height: 120,
          width: 120,
          placeholder: (BuildContext context, String url) => Container(
            height: 120,
            width: 120,
            color: TWColors.gray.shade300,
          ),
        ),
      ),
    );

    final Widget details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          screenData?.podcast?.title ?? title,
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Container(height: 8),
        Text(
          screenData?.podcast?.author ?? author,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w400,
                color: TWColors.gray.shade900,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );

    final podcastActionsBloc = Provider.of<PodcastActionsBloc>(context);

    final Widget actions = Container(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 0.65,
              child: FlatButton(
                onPressed: () => screenData != null && screenData.isSubscribed
                    ? podcastActionsBloc.addAction(
                        PodcastAction.unsubscribe(podcast: screenData.podcast),
                      )
                    : podcastActionsBloc.addAction(
                        PodcastAction.subscribe(podcast: screenData.podcast),
                      ),
                color: screenData?.isSubscribed ?? isSubscribed
                    ? Colors.grey.shade300
                    : TWColors.purple.shade600,
                textColor: screenData?.isSubscribed ?? isSubscribed
                    ? Colors.grey.shade800
                    : Colors.grey.shade100,
                child: Text(
                  screenData?.isSubscribed ?? isSubscribed
                      ? 'SUBSCRIBED'
                      : 'SUBSCRIBE',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: screenData?.isSubscribed ?? isSubscribed
                            ? Colors.grey.shade900
                            : Colors.white,
                        fontSize: 12.5,
                        letterSpacing: 0.6,
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

    return FadeTransition(
      opacity: animation.podcastDetailsOpacity,
      child: Container(
        height: flexibleAreaHeight,
        padding: const EdgeInsets.only(top: 6),
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
    return oldDelegate != this;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
