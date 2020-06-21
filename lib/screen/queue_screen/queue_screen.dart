import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/screen/queue_screen/widgets/queue_header_delegate.dart';
import 'package:phenopod/screen/queue_screen/widgets/queue_list.dart';
import 'package:phenopod/widgets/screen/layout.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/model/main.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<Queue>(
        stream: audioPlayerBloc.queue,
        builder: (context, snapshot) {
          return ScreenLayout(
            header: QueueHeaderDelegate(),
            body: snapshot.hasData
                ? QueueList(queue: snapshot.data)
                : Container(
                    constraints: BoxConstraints.expand(),
                    alignment: Alignment.center,
                    child: Text('No Items in queue'),
                  ),
          );
        },
      ),
    );
  }
}
