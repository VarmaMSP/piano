import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/episodes/episodes_bloc.dart';
import 'package:piano/screens/home.dart';
import 'package:piano/utils/request.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phenopod'),
        ),
        body: BlocProvider(
          create: (context) => EpisodesBloc(request: Request())..add(Fetch()),
          child: HomePage(),
        ),
      ),
    );
  }
}
