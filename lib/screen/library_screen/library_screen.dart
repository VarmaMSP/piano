// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<AppNavigationBloc>(context, listen: false)
                  .pushScreen(Screen.downloadsScreen());
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 32,
              color: Colors.grey.shade200,
              child: Text('Downloads Page'),
            ),
          )
        ],
      ),
    );
  }
}
