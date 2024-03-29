// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

class HomeHeaderDelegate implements SliverPersistentHeaderDelegate {
  HomeHeaderDelegate({
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
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: forceElevated
            ? [BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: scrollToTop,
              child: Text(
                'Phenopod',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple.shade700,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(14, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 24,
                    color: TWColors.gray.shade700,
                  ),
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/search'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    size: 24,
                    color: TWColors.gray.shade700,
                  ),
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
