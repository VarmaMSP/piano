import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
