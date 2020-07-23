// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';

enum QueueScreenOptions {
  clearQueue,
}

class QueueScreenMenu extends StatelessWidget {
  QueueScreenMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<QueueScreenOptions>(
      icon: Icon(
        Icons.more_vert,
        color: TWColors.gray.shade700,
        size: 22,
      ),
      elevation: 8,
      offset: const Offset(-10, 40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (context) {
        return QueueScreenOptions.values
            .map(
              (option) => PopupMenuItem<QueueScreenOptions>(
                value: option,
                height: 46,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: TWColors.gray.shade800),
                child: Text(_queueScreenOptionsToString(option)),
              ),
            )
            .toList();
      },
      onSelected: (option) {
        switch (option) {
          case QueueScreenOptions.clearQueue:
            Provider.of<AudioPlayerBloc>(context, listen: false)
                .addQueueAction(QueueAction.clearQueue());
            break;
        }
      },
    );
  }

  // ignore: missing_return
  String _queueScreenOptionsToString(QueueScreenOptions option) {
    switch (option) {
      case QueueScreenOptions.clearQueue:
        return 'Clear queue';
    }
  }
}
