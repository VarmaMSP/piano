import 'package:flutter/material.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/widgets/home_view/widgets/categories.dart';
import 'package:phenopod/widgets/home_view/widgets/curation.dart';
import 'package:phenopod/widgets/home_view/widgets/trending_podcasts.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key key,
    @required this.curations,
    @required this.categories,
    @required this.controller,
  }) : super(key: key);

  final List<Curation> curations;
  final List<Category> categories;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    // return NestedScrollView(
    //   controller: controller,
    //   headerSliverBuilder: (BuildContext context, _) {
    //     return <Widget>[
    //       SliverOverlapAbsorber(
    //          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
    //           context,
    //         ),
    //         sliver: ,
    //       ),
    //     ];
    //   },
    // )

    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: TrendingPodcasts(trending: curations[0].podcasts),
        ),
        SliverToBoxAdapter(child: Categories(categories: categories)),
        ...curations
            .sublist(1)
            .map(
              (curation) => SliverToBoxAdapter(
                child: CurationView(curation: curation),
              ),
            )
            .toList(),
      ],
    );
  }
}
