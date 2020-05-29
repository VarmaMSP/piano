import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHeader(context),
        Expanded(
          child: Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 45),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 23,
                color: TWColors.gray.shade700,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
