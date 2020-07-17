// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/model/main.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Browse by category',
              style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
                color: TWColors.gray.shade800,
              ),
            ),
          ),
          Container(height: 20),
          Wrap(
            alignment: WrapAlignment.start,
            children: categories.map(_buildCategoryItem).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Category category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: EdgeInsets.only(right: 8, bottom: 14),
      decoration: BoxDecoration(
        color: TWColors.green.shade200,
        border: Border.all(color: TWColors.green.shade300, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          color: TWColors.gray.shade900,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
