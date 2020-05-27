import 'dart:async';
// import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/request.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({this.request});

  final Request request;

  @override
  HomeScreenState get initialState => HomeScreenInitial();

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    final state = this.state;

    try {
      /// Load initial data
      if (event is Load && state is HomeScreenInitial) {
        final response = await request.get('/');
        yield HomeScreenLoaded(curations: response.curations);
      }
    } catch (err) {
      yield HomeScreenError(errMsg: err.toString());
    }
  }
}