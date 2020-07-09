import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:phenopod/animation/podcast_screen_animation.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/hook/use_tab_controller.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/screen/layout.dart';
import 'package:provider/provider.dart';

import 'widgets/about_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/podcast_header_delegate.dart';
import 'podcast_screen_bloc.dart';

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
    final tabController = useTabController(length: 2);
    final podcastScreenBloc = useMemoized(() {
      final context = useContext();
      final store = Provider.of<Store>(context);
      final podcastAcionsBloc = Provider.of<PodcastActionsBloc>(context);
      return PodcastScreenBloc(
        urlParam: urlParam,
        store: store,
        podcastActionsBloc: podcastAcionsBloc,
      );
    }, []);
    final podcastScreenAnimation = PodcastScreenAnimation(
      controller: useAnimationController(),
    );

    useEffect(() => podcastScreenBloc.dispose, []);

    return StreamBuilder<PodcastScreenData>(
      stream: podcastScreenBloc.screenData,
      builder: (context, snapshot) {
        return ScreenLayout(
          header: PodcastHeaderDelegate(
            tabController: tabController,
            urlParam: urlParam,
            title: title,
            author: author,
            screenData: snapshot.data,
            animation: podcastScreenAnimation,
          ),
          body: !snapshot.hasData
              ? Container(
                  constraints: BoxConstraints.expand(),
                  child: Center(child: CircularProgressIndicator()),
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
