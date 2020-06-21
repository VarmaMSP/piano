import 'package:flutter/material.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(onPressed: () {}, child: Text('no queue')),
                  Text(
                    'Published on',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: TWColors.gray.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(),
            alignment: Alignment.center,
            child: Text('${snapshot.data}'),
          );
        },
      ),
    );
  }
}
