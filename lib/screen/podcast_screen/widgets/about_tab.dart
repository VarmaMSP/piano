import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({
    Key key,
    @required this.screenData,
  }) : super(key: key);

  final PodcastScreenData screenData;

  @override
  Widget build(BuildContext context) {
    if (screenData == null) {
      return Container();
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: CustomScrollView(
          key: const PageStorageKey('about'),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  screenData.podcast.description
                      .replaceAll('\n', ' ')
                      .replaceAll('&nbsp;', ' ')
                      .replaceAll('&amp', '&'),
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 13.5,
                    color: TWColors.gray.shade800,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 8),
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: <Widget>[
                    _link(screenData.podcast.link, 'Website', Icons.launch),
                    _link(screenData.podcast.feedUrl, 'RSS', Icons.launch),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: Colors.blue.shade700,
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
