import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano/screens/podcast.dart';
import 'package:bloc/bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
          preferredSize: Size(double.infinity, 100),
          child: Container(
            height: 80,
            child: Text('Phenopod'),
            // decoration: BoxDecoration(
            //   border: Border(bottom: BorderSide(color: Colors.black12)),
            // ),
          ),
        ),
        body: PodcastPage(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 8,
          selectedIconTheme: IconThemeData(size: 21),
          selectedLabelStyle: TextStyle(
            height: 1.5,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.45,
          ),
          selectedItemColor: TWColors.blue.shade700,
          unselectedIconTheme: IconThemeData(size: 21),
          showUnselectedLabels: false,
          unselectedItemColor: TWColors.gray.shade600,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              title: Text('Feeds'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              title: Text('Playlists'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              title: Text('Profile'),
            ),
          ],
        ),
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
