part of 'podcast_bloc.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();
}

class PodcastInitial extends PodcastState {
  @override
  List<Object> get props => [];
}

class PodcastLoaded extends PodcastState {
  final Podcast podcast;
  final List<Episode> episodes;
  final bool loadedAll;

  const PodcastLoaded({
    this.podcast,
    this.episodes,
    this.loadedAll,
  });

  @override
  List<Object> get props => [podcast, episodes, loadedAll];

  @override
  String toString() =>
      'PodcastLoaded { podcast: ${podcast.title}, episodesCount: ${episodes.length}} ';
}

class PodcastError extends PodcastState {
  final String errMsg;

  const PodcastError({this.errMsg});

  @override
  List<Object> get props => [errMsg];

  @override
  String toString() => 'PodcastError { errMsg: $errMsg }';
}
