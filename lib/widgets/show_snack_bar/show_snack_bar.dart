import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter/scheduler.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:provider/provider.dart';

import 'show_snack_bar_bloc.dart';

class ShowSnackBar extends StatefulWidget {
  const ShowSnackBar({Key key}) : super(key: key);

  @override
  _ShowSnackBarState createState() => _ShowSnackBarState();
}

class _ShowSnackBarState extends State<ShowSnackBar> {
  ShowSnackBarBloc _showSnackBarBloc;
  StreamSubscription<dynamic> _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _showSnackBarBloc = ShowSnackBarBloc(
      podcastActionsBloc: Provider.of<PodcastActionsBloc>(
        context,
        listen: false,
      ),
    );
    _notificationSubscription = _showSnackBarBloc.notifications.listen(
      (n) => _showSnackBar(context, n),
    );
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
    _showSnackBarBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _showSnackBar(BuildContext context, Notification notification) {
    notification.when(
      subscribed: (data) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Flushbar(
          message: 'Subscription added.',
          duration: Duration(seconds: 2),
        )..show(context),
      ),
      unsubscribed: (data) => SchedulerBinding.instance.addPostFrameCallback(
        (_) => Flushbar(
          message: 'Unsubscribed.',
          duration: Duration(seconds: 2),
        )..show(context),
      ),
    );
  }
}
