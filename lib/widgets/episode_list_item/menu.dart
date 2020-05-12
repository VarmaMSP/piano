import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      child: PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: TWColors.gray.shade600,
          size: 22,
        ),
        padding: EdgeInsets.all(0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        itemBuilder: (context) {
          return <String>[
            'Save to playlist',
            'Save to Listen later',
            'Add to queue',
          ].map((t) {
            return PopupMenuItem(
              value: t,
              child: Text(t),
            );
          }).toList();
        },
      ),
    );
  }
}
