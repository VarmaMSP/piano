part of 'podcast_bloc.dart';

abstract class PodcastEvent extends Equatable {
  const PodcastEvent();
}

class Load extends PodcastEvent {
  @override
  List<Object> get props => <Object>[];
}
