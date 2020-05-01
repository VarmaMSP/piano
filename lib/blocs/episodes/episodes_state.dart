part of 'episodes_bloc.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();
}

class EpisodesInitial extends EpisodesState {
  @override
  List<Object> get props => [];
}

class EpisodesError extends EpisodesState {
  final String errMsg;

  const EpisodesError({this.errMsg});

  @override
  List<Object> get props => [];
}

class EpisodeLoaded extends EpisodesState {
  final List<Episode> episodes;

  const EpisodeLoaded({this.episodes});

  @override
  List<Object> get props => [];
}
