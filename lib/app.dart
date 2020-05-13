import 'package:flutter/material.dart';
import 'package:piano/route_generator.dart';
import 'package:piano/widgets/app_bottom_navigation_bar.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKey.currentState.maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0, 0),
          child: Container(),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 56),
              child: Navigator(
                key: navigatorKey,
                initialRoute: '/',
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: AppBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }
}
