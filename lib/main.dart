import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano/app/main.dart';
// import 'package:piano/route_generator.dart';
// import 'package:piano/screens/home/page.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return const MaterialApp(
      title: 'Phenopod',
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(
      Bloc<dynamic, dynamic> bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
