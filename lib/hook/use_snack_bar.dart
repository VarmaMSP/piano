// Flutter imports:
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';

void useSnackBar() {
  useEffect(() {
    final context = useContext();

    final eventBus = Provider.of<EventBus>(context, listen: false);
    final eventSubscription = eventBus.on().listen((e) {
      (e as AppEvent).maybeMap(
        subscribeToPodcast: (data) {
          if (data.synced) {
            Flushbar(
              message: 'Subscription added.',
              duration: Duration(seconds: 4),
              animationDuration: Duration(milliseconds: 250),
              isDismissible: true,
            )..show(context);
          }
        },
        unsubscribeFromPodcast: (data) {
          if (data.synced) {
            Flushbar(
              message: 'Unsubscribed.',
              duration: Duration(seconds: 4),
              animationDuration: Duration(milliseconds: 250),
              isDismissible: true,
            )..show(context);
          }
        },
        orElse: () {},
      );
    });

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
      eventSubscription.cancel();
      connectivitySubscription.cancel();
    };
  }, []);
}
