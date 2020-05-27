import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

final Map<String, Style> htmlStyle = {
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
};

class HTML extends StatefulWidget {
  const HTML({
    Key key,
    @required this.id,
    @required this.document,
  }) : super(key: key);

  final String id;
  final String document;

  @override
  _HTMLState createState() => _HTMLState();
}

class _HTMLState extends State<HTML> {
  String _lastId;
  Widget _lastWidget;

  @override
  Widget build(BuildContext context) {
    if (_lastId != widget.id || _lastWidget == null) {
      _lastId = widget.id;
      _lastWidget = Html(
        data: widget.document,
        onLinkTap: (url) async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
        style: htmlStyle,
      );
    }

    return _lastWidget;
  }
}
