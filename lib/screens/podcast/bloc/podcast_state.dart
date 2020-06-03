part of 'podcast_bloc.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();
}

class PodcastInitial extends PodcastState {
  @override
  List<Object> get props => <Object>[];
}

class PodcastLoaded extends PodcastState {
  const PodcastLoaded({
    this.podcast,
    this.episodes,
    this.loadedAll,
  });

  final Podcast podcast;
  final List<Episode> episodes;
  final bool loadedAll;

  @override
  List<Object> get props => <Object>[podcast, episodes, loadedAll];

  @override
  String toString() =>
      'PodcastLoaded { podcast: ${podcast.title}, episodesCount: ${episodes.length}}';
}

class PodcastError extends PodcastState {
  const PodcastError({this.errMsg});

  final String errMsg;

  @override
  List<Object> get props => <Object>[errMsg];

  @override
  String toString() => 'PodcastError { errMsg: $errMsg }';
}
