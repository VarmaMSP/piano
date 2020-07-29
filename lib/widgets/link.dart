// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/models/main.dart';

class PodcastLink extends StatelessWidget {
  const PodcastLink({
    Key key,
    @required this.child,
    @required this.podcast,
  }) : super(key: key);

  final Widget child;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(
          '/podcast',
          arguments: {
            'urlParam': podcast.urlParam,
            'title': podcast.title,
            'author': podcast.author,
            'isSubscribed': false,
          },
        );
      },
      child: child,
    );
  }
}
