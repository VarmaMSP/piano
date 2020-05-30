import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

enum PageType { normal, tab }

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({
    Key key,
    @required this.pageType,
  }) : super(key: key);

  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (pageType == PageType.normal)
          _buildNormalPageAppBar(context)
        else
          _buildTabPageAppBar(),
        Expanded(
          child: Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(),
            child: Center(child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }

  Widget _buildNormalPageAppBar(BuildContext context) {
    return Container(
      height: 45,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(-12, 0),
            child: Material(
              color: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 23,
                  color: TWColors.gray.shade700,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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

  Widget _buildTabPageAppBar() {
    return Container(
      height: 45,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 18),
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
}
