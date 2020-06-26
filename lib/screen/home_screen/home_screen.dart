import 'package:flutter/material.dart';
import 'package:phenopod/model/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'widgets/trending.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'widgets/categories.dart';
import 'home_screen_bloc.dart';

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
    _homeScreenBloc = HomeScreenBloc();
  }

  @override
  void dispose() {
    _homeScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Tuple2<List<Curation>, List<Category>>>(
      stream: Rx.combineLatest2(
        _homeScreenBloc.curations,
        _homeScreenBloc.categories,
        (a, b) => Tuple2(a, b),
      ),
      builder: (context, snapshot) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 2,
              backgroundColor: Colors.white,
              title: Text(
                'Phenopod',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.purple.shade800,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 23,
                    color: TWColors.gray.shade700,
                  ),
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .pushNamed('/search'),
                ),
              ],
            ),
            if (!snapshot.hasData)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  color: Colors.white,
                  constraints: BoxConstraints.expand(),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (snapshot.hasData)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Trending(
                    trending: snapshot.data.item1.fold<List<Podcast>>(
                      [],
                      (acc, curation) => [
                        ...acc,
                        ...curation.podcasts,
                      ],
                    ).toList(),
                  ),
                ),
              ),
            if (snapshot.hasData)
              SliverToBoxAdapter(
                child: Categories(categories: snapshot.data.item2),
              ),
          ],
        );
      },
    );
  }
}
