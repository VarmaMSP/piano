import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(8, -10),
      child: PopupMenuButton(
        icon: Icon(Icons.more_vert, color: Colors.black54),
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
