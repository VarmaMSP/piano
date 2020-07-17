// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/bloc/podcast_actions_bloc.dart';

void useSnackBar() {
  useEffect(() {
    final context = useContext();

    final podcastActionsBloc = Provider.of<PodcastActionsBloc>(
      context,
      listen: false,
    );
    final podcastActionsSubscription = podcastActionsBloc.actions.listen(
      (a) => a.when(
        subscribed: (data) {
          if (data.synced) {
            Flushbar(
              message: 'Subscription added.',
              duration: Duration(seconds: 6),
              animationDuration: Duration(milliseconds: 250),
              isDismissible: true,
            )..show(context);
          }
        },
        unsubscribed: (data) {
          if (data.synced) {
            Flushbar(
              message: 'Unsubscribed.',
              duration: Duration(seconds: 6),
              animationDuration: Duration(milliseconds: 250),
              isDismissible: true,
            )..show(context);
          }
        },
      ),
    );

    final connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(
      (result) {
        switch (result) {
          case ConnectivityResult.wifi:
            break;
          case ConnectivityResult.mobile:
            break;
          case ConnectivityResult.none:
            Flushbar(
              message: 'Unsubscribed.',
              duration: Duration(seconds: 6),
              animationDuration: Duration(milliseconds: 250),
              backgroundColor: Colors.red,
            )..show(context);
            break;
        }
      },
    );

    return () {
      podcastActionsSubscription.cancel();
      connectivitySubscription.cancel();
    };
  }, []);
}
