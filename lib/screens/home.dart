import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/home_screen/home_screen_bloc.dart';
import 'package:phenopod/screens/loading.dart';
import 'package:phenopod/utils/request.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc;

  @override
  void initState() {
    super.initState();
    _homeScreenBloc = HomeScreenBloc(request: Request())..add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      bloc: _homeScreenBloc,
      builder: (context, state) {
        if (state is HomeScreenInitial) {
          return const LoadingPage();
        }

        if (state is HomeScreenError) {
          return Center(
            child: Text(state.errMsg),
          );
        }

        final s = state as HomeScreenLoaded;
        return ListView.builder(
          itemCount: s.curations.length,
          itemBuilder: (context, index) {
            return Text(s.curations[index].title);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _homeScreenBloc.close();
    super.dispose();
  }
}
