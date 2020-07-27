// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:phenopod/hook/use_provider.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;
import 'package:phenopod/widgets/screen/layout.dart';
import 'search_screen_bloc.dart';
import 'widgets/search_header_delegate.dart';
import 'widgets/suggestions_list.dart';

class SearchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    chromeutils.applySystemUIOverlayStyle();

    final searchScreenBloc = useProvider(
      create: (_) => SearchScreenBloc(),
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
          return ScreenLayout(
            header: SearchHeaderDelegate(
              focusNode: focusNode,
              searchBarController: textController,
            ),
            body: snapshot.hasData
                ? SuggestionsList(suggestions: snapshot.data)
                : Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(),
                    child: Text(
                      'Search for podcasts, episodes, topics, person...',
                    ),
                  ),
          );
        },
      ),
    );
  }
}
