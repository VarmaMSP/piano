import 'package:flutter/material.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key key, @required this.podcast}) : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final overlapInjector = SliverOverlapInjector(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
        context,
      ),
    );

    final description = Text(
      podcast.description,
      style: TextStyle(
        height: 1.65,
        fontSize: 14,
        color: TWColors.gray.shade900,
        letterSpacing: 0.18,
      ),
    );

    final links = Transform.translate(
      offset: Offset(-10, 0),
      child: Row(
        children: <Widget>[
          _link(podcast.link, 'Website', Icons.launch),
          _link(podcast.feedUrl, 'RSS', Icons.launch),
        ],
      ),
    );

    return CustomScrollView(
      slivers: <Widget>[
        overlapInjector,
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, right: 12, left: 12),
            child: Column(
              children: <Widget>[
                description,
                Container(height: 12),
                links,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _link(String url, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: FlatButton(
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
            Container(width: 3),
            Icon(icon, size: 14, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
