// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/animation/episode_screen_animation.dart';
import 'package:phenopod/hook/use_provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/episode_screen/widgets/episode_header_delegate.dart';
import 'package:phenopod/screen/episode_screen/widgets/episode_screen_content.dart';
import 'package:phenopod/store/store.dart';
import 'episode_screen_bloc.dart';

class EpisodeScreen extends HookWidget {
  const EpisodeScreen({
    Key key,
    @required this.urlParam,
  }) : super(key: key);

  final String urlParam;

  @override
  Widget build(BuildContext context) {
    final episodeScreenBloc = useProvider(
      create: (context) => EpisodeScreenBloc(
        urlParam: urlParam,
        store: Provider.of<Store>(context),
        eventBus: Provider.of<EventBus>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    final episodeScreenAnimation = EpisodeScreenAnimation(
      controller: useAnimationController(),
    );

    final scrollController = useScrollController();
    useEffect(() {
      final scrollListner = () {
        if (!scrollController.position.outOfRange) {
          episodeScreenAnimation.animateTo(
            scrollController.offset,
            scrollController.position.maxScrollExtent,
          );
        }
      };
      scrollController.addListener(scrollListner);
      return () => scrollController.removeListener(scrollListner);
    }, []);

    return StreamBuilder<EpisodeScreenData>(
      stream: episodeScreenBloc.screenData,
      builder: (context, snapshot) {
        return NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: EpisodeHeaderDelegate(
                  animation: episodeScreenAnimation,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ];
          },
          body: !snapshot.hasData
              ? _buildLoader()
              : EpisodeScreenContent(
                  episode: snapshot.data.episode,
                  podcast: snapshot.data.podcast,
                ),
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
}
