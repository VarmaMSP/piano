import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:flutter/foundation.dart';

class PodcastHeaderDelegate implements SliverPersistentHeaderDelegate {
  PodcastHeaderDelegate({
    @required this.tabController,
    @required this.urlParam,
    @required this.title,
    @required this.author,
    @required this.screenData,
  });

  static const double appBarHeight = 65;
  static const double tabBarHeight = 30;
  static const double flexibleAreaHeight = 145;

  final TabController tabController;
  final String urlParam;
  final String title;
  final String author;
  final PodcastScreenData screenData;

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
            child: _appBar(context, screenData, shrinkOffset),
          ),
          if ((maxExtent - shrinkOffset - minExtent).abs() > 0.001)
            Positioned(
              bottom: tabBarHeight,
              left: 0.0,
              right: 0.0,
              child: _flexibleArea(context, screenData, shrinkOffset),
            ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: _tabBar(context, screenData, shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _appBar(
    BuildContext context,
    PodcastScreenData screenData,
    double shrinkOffset,
  ) {
    return Container(
      height: appBarHeight,
      padding: EdgeInsets.only(bottom: 5),
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
                  color: TWColors.gray.shade700,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: SizedBox(
                    width: 42,
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 22,
                        color: TWColors.gray.shade700,
                      ),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/search'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar(
    BuildContext context,
    PodcastScreenData screenData,
    double shrinkOffset,
  ) {
    if (screenData == null) {
      return Container();
    }

    return Container(
      height: tabBarHeight,
      alignment: Alignment.bottomLeft,
      transform: Matrix4.translationValues(-14, 0, 0),
      child: TabBar(
        isScrollable: true,
        indicatorColor: Color(0xffffbe0b),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.5,
        labelColor: Colors.grey.shade900,
        labelStyle: Theme.of(context).textTheme.headline6,
        unselectedLabelColor: TWColors.gray.shade600,
        unselectedLabelStyle: Theme.of(context).textTheme.headline6,
        labelPadding: EdgeInsets.only(left: 14, right: 14, bottom: 6),
        controller: tabController,
        tabs: const <Widget>[
          Tab(text: ' Episodes '),
          Tab(text: ' About '),
        ],
      ),
    );
  }

  Widget _flexibleArea(
    BuildContext context,
    PodcastScreenData screenData,
    double shrinkOffset,
  ) {
    if (screenData == null && title == null) {
      return Container();
    }

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
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );

    final podcastActionsBloc = Provider.of<PodcastActionsBloc>(context);

    final Widget actions = screenData == null
        ? Container()
        : Container(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 1.0,
                    widthFactor: 0.7,
                    child: FlatButton(
                      onPressed: () => screenData.isSubscribed
                          ? podcastActionsBloc.unsubscribe(screenData.podcast)
                          : podcastActionsBloc.subscribe(screenData.podcast),
                      color: screenData.isSubscribed
                          ? Colors.grey.shade300
                          : TWColors.purple.shade600,
                      textColor: screenData.isSubscribed
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                      child: Text(
                        screenData.isSubscribed ? 'SUBSCRIBED' : 'SUBSCRIBE',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: screenData.isSubscribed
                                  ? Colors.grey.shade900
                                  : Colors.white,
                              fontSize: 12.5,
                              letterSpacing: 0.5,
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
        padding: const EdgeInsets.only(top: 2),
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
