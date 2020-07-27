// Package imports:
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    show NestedScrollViewRefreshIndicator;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/hook/use_provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/screen/subscriptions_screen/widgets/subscriptions_feed.dart';
import 'package:phenopod/screen/subscriptions_screen/widgets/subscriptions_header_delegate.dart';
import 'package:phenopod/store/store.dart';
import 'subscriptions_screen_bloc.dart';

class SubscriptionsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final nestedScrollViewKey = useMemoized(
      () => GlobalKey<NestedScrollViewState>(),
      [],
    );

    final subscriptionsScreenBloc = useProvider(
      create: (context) => SubscriptionsScreenBloc(
        store: Provider.of<Store>(context),
      ),
      dispose: (_, value) => value.dispose(),
    );

    return StreamBuilder<SubscriptionsScreenData>(
      stream: subscriptionsScreenBloc.screenData,
      builder: (context, snapshot) {
        return NestedScrollViewRefreshIndicator(
          onRefresh: () async {
            if (snapshot.hasData) {
              await Provider.of<Store>(context, listen: false)
                  .subscription
                  .refresh();
            }
            return true;
          },
          color: TWColors.purple.shade600,
          displacement: 80,
          child: NestedScrollView(
            key: nestedScrollViewKey,
            floatHeaderSlivers: true,
            physics: const AlwaysScrollableScrollPhysics(),
            headerSliverBuilder: (context, hasScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: SubscriptionsHeaderDelegate(
                    forceElevated: hasScrolled,
                    scrollToTop: () => nestedScrollViewKey
                        .currentState.outerController
                        .jumpTo(0.0),
                  ),
                ),
              ];
            },
            body: snapshot.hasData && snapshot.data.podcasts.isNotEmpty
                ? SubscriptionsFeed(
                    screenData: snapshot.data,
                    loadMoreEpisodes: subscriptionsScreenBloc.loadMoreEpisodes,
                  )
                : Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(),
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 100),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '😅',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 48),
                          ),
                          Container(height: 20),
                          Text(
                            'Looks like you haven\'t subscribed to any podcasts',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontSize: 20,
                                      height: 1.5,
                                      color: TWColors.gray.shade900,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
