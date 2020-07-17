// Flutter imports:
import 'package:flutter/material.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({
    Key key,
    this.header,
    this.body,
  }) : super(key: key);

  final SliverPersistentHeaderDelegate header;
  final Widget body;

  @override
  _ScreenLayoutState createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, _) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: widget.header,
            ),
          ),
        ];
      },
      body: widget.body,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
