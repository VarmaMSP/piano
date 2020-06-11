part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscribeToPodcast extends SubscriptionEvent {
  SubscribeToPodcast(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => [podcastId];
}

class UnsubscribeToPodcast extends SubscriptionEvent {
  UnsubscribeToPodcast(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => [podcastId];
}
