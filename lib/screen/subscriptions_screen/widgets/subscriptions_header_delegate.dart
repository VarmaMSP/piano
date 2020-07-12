import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SubscriptionsHeaderDelegate implements SliverPersistentHeaderDelegate {
  SubscriptionsHeaderDelegate({
    @required this.forceElevated,
    this.scrollToTop,
  });

  final bool forceElevated;
  final void Function() scrollToTop;

  @override
  double get maxExtent => 65.0;

  @override
  double get minExtent => 65.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          if (forceElevated)
            BoxShadow(color: TWColors.gray.shade400, blurRadius: 2),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: scrollToTop,
            child: Text(
              'Phenopod',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: TWColors.gray.shade800),
              textAlign: TextAlign.left,
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
