import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;
import 'package:flutter/services.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/episode_list_item/episode_list_item.dart';
import 'package:provider/provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'widgets/dowloads_header_delegate.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<List<AudioFile>>(
        stream: store.audioFile.watchAll(),
        builder: (context, snapshot) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: DownloadsHeaderDelegate(
                    forceElevated: innerBoxIsScrolled,
                    scrollToTop: () {},
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return 65.0;
            },
            innerScrollPositionKeyBuilder: () {
              return Key('List');
            },
            body: !snapshot.hasData
                ? Container()
                : _buildList(context, snapshot.data),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<AudioFile> audioFiles) {
    return ImplicitlyAnimatedList<AudioFile>(
      items: audioFiles,
      areItemsTheSame: (a, b) => a.episode.id == b.episode.id,
      itemBuilder: (context, animation, audioFile, index) => SizeFadeTransition(
        sizeFraction: 0.7,
        curve: Curves.easeInOut,
        animation: animation,
        child: EpisodeListItem(
          episode: audioFile.episode,
          podcast: audioFile.podcast,
          type: EpisodeListItemType.subscriptionsItem,
        ),
      ),
    );
  }
}
