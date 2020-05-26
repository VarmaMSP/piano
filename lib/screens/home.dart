import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/home_screen/home_screen_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/screens/loading.dart';
import 'package:phenopod/utils/request.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
        return CustomScrollView(
          slivers: s.curations.fold<List<Widget>>(
            [],
            (acc, curation) => [
              ...acc,
              ..._buildCuration(context, curation),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _homeScreenBloc.close();
    super.dispose();
  }

  List<Widget> _buildCuration(BuildContext context, Curation curation) {
    return [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 16, left: 16, right: 16),
          child: Text(
            curation.title,
            style: TextStyle(
              fontSize: 18,
              color: TWColors.gray.shade900,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(bottom: 20),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildPodcastThumbnail(
                  context,
                  curation.podcasts[index],
                  110,
                  isFirst: index == 0,
                  isLast: index == curation.podcasts.length - 1,
                );
              },
              itemCount: curation.podcasts.length,
            ),
          ),
        ),
      )
    ];
  }

  Widget _buildPodcastThumbnail(
    BuildContext context,
    Podcast podcast,
    double size, {
    bool isFirst,
    bool isLast,
  }) {
    final imageUrl =
        'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg';

    var padding = EdgeInsets.zero;
    if (isFirst) {
      padding = EdgeInsets.only(left: 16, right: 8);
    } else if (isLast) {
      padding = EdgeInsets.only(left: 8, right: 16);
    } else {
      padding = EdgeInsets.only(left: 8, right: 8);
    }

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/podcast',
            arguments: {'urlParam': podcast.urlParam},
          );
        },
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(color: TWColors.gray.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              placeholder: (BuildContext context, String url) => Container(
                height: size,
                width: size,
                color: TWColors.gray.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
