// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;

// Project imports:
import 'package:phenopod/screen/library_screen/widgets/library_screen_content.dart';
import 'widgets/library_header_delegate.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;

class LibraryScreen extends HookWidget {
  const LibraryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
    );

    return NestedScrollView(
      key: nestedScrollViewKey,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, hasScrolled) {
        return [
          SliverPersistentHeader(
            delegate: LibraryHeaderDelegate(
              forceElevated: hasScrolled,
              scrollToTop: () =>
                  nestedScrollViewKey.currentState.outerController.jumpTo(0.0),
            ),
          ),
        ];
      },
      body: LibraryScreenContent(),
    );
  }
}
