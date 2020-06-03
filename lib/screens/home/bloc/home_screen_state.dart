part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenLoaded extends HomeScreenState {
  const HomeScreenLoaded({
    this.curations,
    this.categories,
  });

  final List<Curation> curations;
  final List<Category> categories;

  @override
  List<Object> get props => <Object>[curations];

  @override
  String toString() => 'HomeScreenLoaded { curationCount: ${curations.length}}';
}

class HomeScreenError extends HomeScreenState {
  const HomeScreenError({this.errMsg});

  final String errMsg;

  @override
  List<Object> get props => <Object>[errMsg];

  @override
  String toString() => 'HomeScreenError { errMsg: $errMsg }';
}
