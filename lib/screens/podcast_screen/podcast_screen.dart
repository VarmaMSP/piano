// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animations/podcast_screen_animation.dart';
import 'package:phenopod/hooks/use_provider.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'podcast_screen_bloc.dart';
import 'widgets/about_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/podcast_header_delegate.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;

class PodcastScreen extends HookWidget {
  PodcastScreen({Key key, @required this.urlParam, @required this.placeholder})
      : super(key: key);

  final String urlParam;
  final PodcastPlaceholder placeholder;

  @override
  Widget build(BuildContext context) {
    final podcastScreenAnimation = PodcastScreenAnimation(
      controller: useAnimationController(),
    );

    final tabController = useTabController(
      initialLength: 2,
    );

    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
      [],
    );

    final podcastScreenBloc = useProvider(
      create: (context) => PodcastScreenBloc(
        urlParam: urlParam,
        store: Provider.of<Store>(context),
        eventBus: Provider.of<EventBus>(context),
      ),
      dispose: (_, value) => value.dispose(),
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
                  urlParam: urlParam,
                  placeholder: placeholder,
                  screenData: snapshot.data,
                  tabController: tabController,
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
              ? _buildLoader()
              : _buildTabs(snapshot.data, podcastScreenBloc, tabController),
        );
      },
    );
  }

  Widget _buildLoader() {
    return Container(
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
    );
  }

  Widget _buildTabs(
    PodcastScreenData screenData,
    PodcastScreenBloc podcastScreenBloc,
    TabController tabController,
  ) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        EpisodesTab(
          screenData: screenData,
          loadMoreEpisodes: podcastScreenBloc.loadMoreEpisodes,
        ),
        AboutTab(
          screenData: screenData,
        ),
      ],
    );
  }
}
