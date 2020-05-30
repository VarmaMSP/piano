import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/home_screen/home_screen_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/screens/home/widgets/trending.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/widgets/screen/header/tab_screen.dart';
import 'package:phenopod/widgets/screen/layout.dart';
import 'package:phenopod/widgets/screen/loading_layout.dart';

import 'widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }) : super(key: key);

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
  void dispose() {
    _homeScreenBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      bloc: _homeScreenBloc,
      builder: (context, state) {
        if (state is HomeScreenInitial) {
          return LoadingLayout(pageType: PageType.tab);
        }

        if (state is HomeScreenLoaded) {
          return ScreenLayout(
            header: TabScreenHeaderDelegate(),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Trending(
                      trending: state.curations.fold<List<Podcast>>(
                        [],
                        (acc, curation) => [
                          ...acc,
                          ...curation.podcasts,
                        ],
                      ).toList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Categories(categories: state.categories),
                ),
              ],
            ),
          );
        }

        return null;
      },
    );
  }
}
