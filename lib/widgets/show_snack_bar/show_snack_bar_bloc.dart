import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:super_enum/super_enum.dart';
import 'package:rxdart/rxdart.dart';

part 'show_snack_bar_bloc.g.dart';

@superEnum
enum _Notification {
  @object
  Subscribed,
  @object
  Unsubscribed,
}

class ShowSnackBarBloc {
  final PodcastActionsBloc podcastActionsBloc;

  /// Stream controller for notifications
  final PublishSubject<Notification> _notifications =
      PublishSubject<Notification>();

  ShowSnackBarBloc({this.podcastActionsBloc}) {
    _handleEvents();
  }

  void _handleEvents() {
    podcastActionsBloc.actions.listen(
      (e) => e.when(
        subscribed: (data) {
          if (data.synced) {
            _notifications.add(Notification.subscribed());
          }
        },
        unsubscribed: (data) {
          if (data.synced) {
            _notifications.add(Notification.unsubscribed());
          }
        },
      ),
    );
  }

  Stream<Notification> get notifications => _notifications.stream;

  Future<void> dispose() async {
    await _notifications.close();
  }
}
