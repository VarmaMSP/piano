// Flutter imports:
import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;

// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/hooks/use_provider.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;
import 'package:phenopod/widgets/empty_screen_placeholder.dart';
import 'search_screen_bloc.dart';
import 'widgets/search_header_delegate.dart';
import 'widgets/suggestions_list.dart';

class SearchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    chromeutils.applySystemUIOverlayStyle();

    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
      [],
    );

    final searchScreenBloc = useProvider(
      create: (context) => SearchScreenBloc(
        store: Provider.of<Store>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    final textController = useTextEditingController();
    useEffect(() {
      final listener = () {
        searchScreenBloc.changeSearchText(textController.text);
      };
      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, []);

    final focusNode = useFocusNode();
    useEffect(() {
      Future.delayed(
        Duration(milliseconds: 200),
        () => focusNode.requestFocus(),
      );
      return () {};
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<List<SearchSuggestion>>(
        stream: searchScreenBloc.suggestions,
        builder: (context, snapshot) {
          return NestedScrollView(
            key: nestedScrollViewKey,
            headerSliverBuilder: (context, hasScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SearchHeaderDelegate(
                    focusNode: focusNode,
                    searchBarController: textController,
                    forceElevated: hasScrolled,
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return 60.0;
            },
            innerScrollPositionKeyBuilder: () {
              return Key('subscriptions');
            },
            body: NestedScrollViewInnerScrollPositionKeyWidget(
              const Key('subscriptions'),
              snapshot.hasData
                  ? SuggestionsList(suggestions: snapshot.data)
                  : EmptyScreenPlaceholder(
                      emoji: '🔍',
                      text: 'Search for podcasts...',
                    ),
            ),
          );
        },
      ),
    );
  }
}
