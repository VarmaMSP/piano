// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

class SearchHeaderDelegate implements SliverPersistentHeaderDelegate {
  SearchHeaderDelegate({
    @required this.focusNode,
    @required this.searchBarController,
  });

  final FocusNode focusNode;
  final TextEditingController searchBarController;

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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: TWColors.gray.shade400,
        style: BorderStyle.solid,
        width: 1,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: TWColors.blue.shade600,
        style: BorderStyle.solid,
        width: 1,
      ),
    );

    return Container(
      height: maxExtent,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.white,
      child: Transform.translate(
        offset: const Offset(6, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 23,
                  color: TWColors.gray.shade700,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ),
            Container(width: 6),
            Expanded(
              child: Container(
                height: 36,
                padding: EdgeInsets.only(right: 24),
                child: TextField(
                  focusNode: focusNode,
                  controller: searchBarController,
                  decoration: InputDecoration(
                    hintText: 'Search for podcasts...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: TWColors.gray.shade700),
                    filled: true,
                    fillColor: TWColors.gray.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0,
                    ),
                    border: border,
                    errorBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    focusedBorder: focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
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
