import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: TWColors.gray.shade600,
          size: 20,
        ),
        padding: const EdgeInsets.all(0),
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        itemBuilder: (BuildContext context) {
          return <String>[
            'Save to playlist',
            'Save to Listen later',
            'Add to queue',
          ].map((String t) {
            return PopupMenuItem<String>(
              value: t,
              child: Text(t),
            );
          }).toList();
        },
      ),
    );
  }
}
