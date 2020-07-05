import 'package:flushbar/flushbar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:provider/provider.dart';

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
              duration: Duration(seconds: 2),
            )..show(context);
          }
        },
        unsubscribed: (data) {
          if (data.synced) {
            Flushbar(
              message: 'Unsubscribed.',
              duration: Duration(seconds: 2),
            )..show(context);
          }
        },
      ),
    );

    return () {
      podcastActionsSubscription.cancel();
    };
  }, []);
}
