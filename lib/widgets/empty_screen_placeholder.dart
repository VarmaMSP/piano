import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EmptyScreenPlaceholder extends StatelessWidget {
  const EmptyScreenPlaceholder({
    Key key,
    @required this.emoji,
    @required this.text,
  }) : super(key: key);

  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 100),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Text(
                    emoji,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48),
                  ),
                  Container(
                    constraints: BoxConstraints.expand(),
                    color: Color.fromRGBO(255, 255, 255, 0.45),
                  )
                ],
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 20,
                    height: 1.5,
                    color: TWColors.gray.shade700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
