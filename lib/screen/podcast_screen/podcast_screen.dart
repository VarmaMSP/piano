// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animation/podcast_screen_animation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/hook/use_value.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'podcast_screen_bloc.dart';
import 'widgets/about_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/podcast_header_delegate.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;


class PodcastScreen extends HookWidget {
  PodcastScreen({
    Key key,
    @required this.urlParam,
    this.title,
    this.author,
  }) : super(key: key);

  final String urlParam;
  final String title;
  final String author;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    final podcastScreenAnimation = PodcastScreenAnimation(
      controller: useAnimationController(),
    );

    final podcastScreenBloc = useValue<PodcastScreenBloc>(
      create: (context) => PodcastScreenBloc(
        urlParam: urlParam,
        store: Provider.of<Store>(context),
        podcastActionsBloc: Provider.of<PodcastActionsBloc>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
    );

    return StreamBuilder<PodcastScreenData>(
      stream: podcastScreenBloc.screenData,
      builder: (context, snapshot) {
        return NestedScrollView(
          key: nestedScrollViewKey,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: PodcastHeaderDelegate(
                  tabController: tabController,
                  urlParam: urlParam,
                  title: title,
                  author: author,
                  screenData: snapshot.data,
                  animation: podcastScreenAnimation,
                  forceElevated: innerBoxIsScrolled,
                  scrollToTop: () => nestedScrollViewKey
                      .currentState.outerController
                      .jumpTo(0.0),
                ),
              ),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return 95.0;
          },
          innerScrollPositionKeyBuilder: () {
            return Key('Tab${tabController.index.toString()}');
          },
          body: !snapshot.hasData
              ? Container(
                  constraints: BoxConstraints.expand(),
                  padding: EdgeInsets.only(bottom: 50),
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 75,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints.expand(
                            width: 25,
                            height: 25,
                          ),
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation(
                              TWColors.blue.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    EpisodesTab(
                      screenData: snapshot.data,
                      loadMoreEpisodes: podcastScreenBloc.loadMoreEpisodes,
                    ),
                    AboutTab(
                      screenData: snapshot.data,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
