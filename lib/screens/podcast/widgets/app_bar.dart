import 'package:flutter/material.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/widgets/podcast_header/podcast_header.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PodcastAppBar extends StatelessWidget {
  const PodcastAppBar({
    Key key,
    @required this.podcast,
    @required this.tabController,
  }) : super(key: key);

  final Podcast podcast;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      forceElevated: false,
      expandedHeight: 240,
      leading: Transform.translate(
        offset: Offset(-4, 0),
        child: Icon(
          Icons.arrow_back,
          size: 24.0,
          color: TWColors.gray.shade700,
        ),
      ),
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        print('constraints=' + constraints.toString());
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: PodcastHeader(podcast: podcast),
            ),
          ),
        );
      }),
      bottom: _TabBar(tabController: tabController),
    );
  }
}

class _TabBar extends StatelessWidget implements PreferredSizeWidget {
  const _TabBar({Key key, @required this.tabController}) : super(key: key);

  final TabController tabController;

  Size get preferredSize => Size(double.infinity, 40);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 40),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: TWColors.gray.shade400,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Transform.translate(
            offset: Offset(-4, 0),
            child: Container(
              height: 40,
              child: TabBar(
                isScrollable: true,
                indicatorColor: TWColors.green.shade900,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.8,
                labelColor: TWColors.teal.shade900,
                labelStyle: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600,
                ),
                controller: tabController,
                tabs: <Widget>[
                  Tab(text: '  Episodes  '),
                  Tab(text: '  About  '),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
