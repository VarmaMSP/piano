import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano/screens/podcast/screen.dart';
import 'package:bloc/bloc.dart';
import 'package:piano/widgets/app_bottom_navigation_bar.dart';

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

    return MaterialApp(
      title: 'Phenopod',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0, 0),
          child: Container(),
        ),
        body: PodcastPage(),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
