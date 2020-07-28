// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/hook/use_provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/episode_screen/widgets/episode_header_delegate.dart';
import 'package:phenopod/store/store.dart';
import 'episode_screen_bloc.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;


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

    return StreamBuilder<EpisodeScreenData>(
        stream: episodeScreenBloc.screenData,
        builder: (context, snapshot) {
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    delegate: EpisodeHeaderDelegate(
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ),
                ];
              },
              pinnedHeaderSliverHeightBuilder: () {
                return 60.0;
              },
              body: !snapshot.hasData
                  ? _buildLoader()
                  : Container(
                      child: Text(snapshot.data.episode.title),
                    ));
        });
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
