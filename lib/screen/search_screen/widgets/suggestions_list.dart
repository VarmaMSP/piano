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
            padding: const EdgeInsets.only(top: 4),
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
              placeholder: PodcastPlaceholder(
                title: suggestion.header,
                author: suggestion.subHeader,
                isSubscribed: false,
              ),
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
              height: 55,
              width: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: '$thumbnailUrl/${suggestion.i}.jpg',
                  fit: BoxFit.fill,
                  height: 60,
                  width: 60,
                  placeholder: (BuildContext context, String url) => Container(
                    height: 60,
                    width: 60,
                    color: TWColors.gray.shade300,
                  ),
                ),
              ),
            ),
            Container(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    suggestion.header,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: TWColors.gray.shade900),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(height: 8),
                  Text(
                    suggestion.subHeader,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: TWColors.gray.shade700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
