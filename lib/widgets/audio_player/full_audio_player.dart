import 'package:flutter/material.dart';

class FullAudioPlayer extends StatelessWidget {
  const FullAudioPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Container(
        constraints: const BoxConstraints.expand(height: 350),
        color: Colors.black45,
      ),
    );
  }
}
