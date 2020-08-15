// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/episode_screen_animation.dart';

class EpisodeHeaderDelegate implements SliverPersistentHeaderDelegate {
  EpisodeHeaderDelegate({
    @required this.animation,
    @required this.forceElevated,
    this.scrollToTop,
  });

  final EpisodeScreenAnimation animation;
  final bool forceElevated;
  final void Function() scrollToTop;

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: forceElevated
            ? [BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(4, 0),
            child: Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 24,
                  color: Colors.blueGrey.shade600,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
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
                      padding: EdgeInsets.only(top: 1),
                      child: Text(
                        'Episode',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: TWColors.gray.shade800),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-4, 0),
            child: IconButton(
              icon: Icon(
                Icons.search_rounded,
                size: 24,
                color: Colors.blueGrey.shade600,
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed('/search'),
            ),
          ),
        ],
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
