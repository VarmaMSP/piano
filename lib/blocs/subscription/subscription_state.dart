part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscribedToPodcast extends SubscriptionState {
  SubscribedToPodcast(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => [podcastId];
}

class UnsubscribedToPodcast extends SubscriptionState {
  UnsubscribedToPodcast(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => [podcastId];
}
