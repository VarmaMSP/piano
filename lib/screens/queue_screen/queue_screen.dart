// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;
import 'package:phenopod/widgets/empty_screen_placeholder.dart';
import 'package:phenopod/widgets/queue_list_item/queue_list_item.dart';
import 'widgets/queue_header_delegate.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    chromeutils.applySystemUIOverlayStyle();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<Queue>(
        initialData: audioPlayerBloc.queue,
        stream: audioPlayerBloc.queueStream,
        builder: (context, snapshot) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: QueueHeaderDelegate(
                    forceElevated: innerBoxIsScrolled,
                    scrollToTop: () {},
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return 60.0;
            },
            innerScrollPositionKeyBuilder: () {
              return Key('List');
            },
            body: snapshot.hasData
                ? _buildList(
                    context,
                    audioPlayerBloc,
                    snapshot.data,
                  )
                : EmptyScreenPlaceholder(
                    emoji: '👻',
                    text: 'You queue is empty',
                  ),
          );
        },
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    AudioPlayerBloc audioPlayerBloc,
    Queue queue,
  ) {
    Widget buildReorderable(
      AudioTrack audioTrack,
      Widget Function(Widget tile) transitionBuilder,
    ) =>
        Reorderable(
          key: ValueKey('${audioTrack.position} ${audioTrack.episode.id}'),
          builder: (context, dragAnimation, inDrag) {
            final item = QueueListItem(
              trackCount: queue.audioTracks.length,
              nowPlayingPosition: queue.nowPlaying.position,
              audioTrack: audioTrack,
              dragAnimation: dragAnimation,
            );
            return dragAnimation.value > 0.0 ? item : transitionBuilder(item);
          },
        );

    return ImplicitlyAnimatedReorderableList<AudioTrack>(
      items: queue.audioTracks,
      shrinkWrap: true,
      areItemsTheSame: (a, b) => a.episode.id == b.episode.id,
      onReorderFinished: (item, from, to, newItems) {
        audioPlayerBloc.addQueueAction(
          QueueAction.changeTrackPosition(from: from, to: to),
        );
      },
      itemBuilder: (context, itemAnimation, item, index) {
        return buildReorderable(item, (child) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: child,
          );
        });
      },
      updateItemBuilder: (context, itemAnimation, item) {
        return buildReorderable(item, (child) {
          return FadeTransition(
            opacity: itemAnimation,
            child: child,
          );
        });
      },
    );
  }
}
