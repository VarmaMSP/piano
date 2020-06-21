import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';

class QueueList extends StatelessWidget {
  const QueueList({Key key, this.queue}) : super(key: key);

  final Queue queue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 50, left: 18, right: 18),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: queue.audioTracks.map((track) {
          return Text('${track.episode.title}');
        }).toList(),
      ),
    );
  }
}
