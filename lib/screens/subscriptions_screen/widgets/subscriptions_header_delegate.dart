// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

class SubscriptionsHeaderDelegate implements SliverPersistentHeaderDelegate {
  SubscriptionsHeaderDelegate({
    @required this.forceElevated,
    this.scrollToTop,
  });

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
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                size: 24,
                color: Colors.blueGrey.shade600,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: scrollToTop,
              behavior: HitTestBehavior.translucent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'phenopod',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 21,
                            color: Colors.purple.shade700,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-4, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 24,
                    color: Colors.blueGrey.shade600,
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

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
