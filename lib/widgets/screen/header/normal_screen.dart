// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'constants.dart';

class NormalScreenHeaderDelegate implements SliverPersistentHeaderDelegate {
  @override
  double get minExtent => appBarHeight;

  @override
  double get maxExtent => appBarHeight + 0.5;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      constraints: BoxConstraints.expand(height: maxExtent - shrinkOffset),
      padding: const EdgeInsets.symmetric(horizontal: appBarHorizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if ((maxExtent - shrinkOffset - minExtent).abs() <= 0.001)
            BoxShadow(color: TWColors.gray.shade400, blurRadius: 2)
        ],
      ),
      child: _buildAppBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: appBarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Phenopod',
            style: TextStyle(
              fontSize: 20,
              color: TWColors.purple.shade900,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          Transform.translate(
            offset: Offset(16, 0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 23,
                color: TWColors.gray.shade700,
              ),
              onPressed: null,
            ),
          ),
        ],
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
