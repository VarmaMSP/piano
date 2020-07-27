// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/home_screen/widgets/home_header_delegate.dart';
import 'package:phenopod/screen/home_screen/widgets/home_screen_feed.dart';
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
        return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, hasScrolled) {
            return [
              SliverPersistentHeader(
                delegate: HomeHeaderDelegate(forceElevated: hasScrolled),
              ),
            ];
          },
          body: snapshot.hasData
              ? HomeScreenFeed(
                  trending: snapshot.data.item1.fold<List<Podcast>>(
                    [],
                    (acc, curation) => [...acc, ...curation.podcasts],
                  ).toList(),
                  categories: snapshot.data.item2,
                )
              : Container(
                  color: Colors.white,
                  constraints: BoxConstraints.expand(),
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 100),
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints.expand(
                        width: 40,
                        height: 40,
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(
                          TWColors.purple.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
