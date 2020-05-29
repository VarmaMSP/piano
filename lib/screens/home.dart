import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/home_screen/home_screen_bloc.dart';
import 'package:phenopod/screens/loading.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/widgets/home_view/main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, @required this.routeObserver}) : super(key: key);

  final RouteObserver<PageRoute> routeObserver;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  HomeScreenBloc _homeScreenBloc;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _homeScreenBloc = HomeScreenBloc(request: Request())..add(Load());
    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _homeScreenBloc.close();
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => _controller.jumpTo(_controller.offset - 55),
    );
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
        return HomeView(
          curations: s.curations,
          categories: s.categories,
          controller: _controller,
        );
      },
    );
  }
}
