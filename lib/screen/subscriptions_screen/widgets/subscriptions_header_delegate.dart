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
  double get maxExtent => 55.0;

  @override
  double get minExtent => 55.0;

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
          Expanded(
            child: GestureDetector(
              onTap: scrollToTop,
              child: Text(
                'Phenopod',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 19,
                      color: TWColors.purple.shade800,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(15, 0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 24,
                color: TWColors.gray.shade700,
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
