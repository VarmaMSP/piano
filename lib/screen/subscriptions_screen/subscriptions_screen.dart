// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/hook/use_value.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/subscriptions_screen/widgets/subscriptions_feed.dart';
import 'package:phenopod/screen/subscriptions_screen/widgets/subscriptions_header_delegate.dart';
import 'package:phenopod/store/store.dart';
import 'subscriptions_screen_bloc.dart';

import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;

class SubscriptionsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final subscriptionsScreenBloc = useValue<SubscriptionsScreenBloc>(
      create: (context) => SubscriptionsScreenBloc(
        store: Provider.of<Store>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
    );

    return StreamBuilder<SubscriptionsScreenData>(
      stream: subscriptionsScreenBloc.screenData,
      builder: (context, snapshot) {
        return NestedScrollView(
          key: nestedScrollViewKey,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, hasScrolled) {
            return [
              SliverPersistentHeader(
                delegate: SubscriptionsHeaderDelegate(
                  forceElevated: hasScrolled,
                  scrollToTop: () => nestedScrollViewKey
                      .currentState.innerController
                      .jumpTo(0.0),
                ),
              ),
            ];
          },
          body: !snapshot.hasData
              ? Container()
              : SubscriptionsFeed(
                  screenData: snapshot.data,
                  loadMoreEpisodes: subscriptionsScreenBloc.loadMoreEpisodes,
                ),
        );
      },
    );
  }
}
