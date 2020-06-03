import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:phenopod/app/root.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(AppRoot());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(
    Bloc<dynamic, dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
