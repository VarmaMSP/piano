part of 'podcast_bloc.dart';

abstract class PodcastEvent extends Equatable {
  const PodcastEvent();
}

class Load extends PodcastEvent {
  @override
  List<Object> get props => <Object>[];
}

class Subscribe extends PodcastEvent {
  Subscribe(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => <Object>[podcastId];
}

class Unsubscribe extends PodcastEvent {
  Unsubscribe(this.podcastId);

  final String podcastId;

  @override
  List<Object> get props => <Object>[podcastId];
}
