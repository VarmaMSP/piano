import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class HTML extends StatelessWidget {
  const HTML({
    Key key,
    @required this.document,
  }) : super(key: key);

  final String document;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: document,
      onLinkTap: (url) async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      style: {
        '*': Style(
          letterSpacing: 0.17,
        ),
        'h1, h2, h3, h4': Style(
          fontSize: FontSize.large,
          color: TWColors.gray.shade700,
        ),
        'p': Style(
          fontSize: FontSize.percent(98),
          color: TWColors.gray.shade700,
        ),
        'a': Style(
          color: TWColors.blue.shade600,
        ),
      },
    );
  }
}
