import 'package:flutter/material.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key key, @required this.podcast}) : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final Widget description = Text(
      podcast.description
          .replaceAll('\n', ' ')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp', '&'),
      style: TextStyle(
        height: 1.5,
        fontSize: 13.5,
        color: TWColors.gray.shade800,
        letterSpacing: 0.25,
      ),
    );

    final Widget links = Transform.translate(
      offset: const Offset(-10, 0),
      child: Row(
        children: <Widget>[
          _link(podcast.link, 'Website', Icons.launch),
          _link(podcast.feedUrl, 'RSS', Icons.launch),
        ],
      ),
    );

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 92),
            description,
            Container(height: 12),
            links,
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
