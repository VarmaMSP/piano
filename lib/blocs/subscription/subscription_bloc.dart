import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/repositories/subscription.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository =
      SubscriptionRepository();

  @override
  SubscriptionState get initialState => SubscriptionInitial();

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is SubscribeToPodcast) {
      await subscriptionRepository.subscribe(event.podcastId);
      yield SubscribedToPodcast(event.podcastId);
    }

    if (event is UnsubscribeToPodcast) {
      await subscriptionRepository.unsubscribe(event.podcastId);
      yield UnsubscribedToPodcast(event.podcastId);
    }
  }
}
