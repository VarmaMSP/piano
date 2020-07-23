// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';

class SuggestionsList extends StatelessWidget {
  const SuggestionsList({
    Key key,
    @required this.suggestions,
  }) : super(key: key);

  final List<SearchSuggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 50),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildPodcastSuggestion(context, suggestions[index]);
                },
                childCount: suggestions.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPodcastSuggestion(
    BuildContext context,
    SearchSuggestion suggestion,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final appNavigationBloc = Provider.of<AppNavigationBloc>(
          context,
          listen: false,
        );
        Navigator.of(context, rootNavigator: true).pop();
        Future.delayed(
          Duration(milliseconds: 400),
          () => appNavigationBloc.pushScreen(
            AppScreen.podcastScreen(
              urlParam: suggestion.i,
              title: suggestion.header,
              author: suggestion.subHeader,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 46,
              width: 46,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: '$thumbnailUrl/${suggestion.i}.jpg',
                  fit: BoxFit.fill,
                  height: 46,
                  width: 46,
                  placeholder: (BuildContext context, String url) => Container(
                    height: 46,
                    width: 46,
                    color: TWColors.gray.shade300,
                  ),
                ),
              ),
            ),
            Container(width: 10),
            Expanded(
              child: Text(suggestion.header),
            ),
          ],
        ),
      ),
    );
  }
}
