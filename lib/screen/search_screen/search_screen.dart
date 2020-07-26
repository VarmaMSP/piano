// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;
import 'package:phenopod/widgets/screen/layout.dart';
import 'search_screen_bloc.dart';
import 'widgets/search_header_delegate.dart';
import 'widgets/suggestions_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenBloc _searchScreenBloc;
  TextEditingController _searchBarController;

  @override
  void initState() {
    super.initState();
    _searchScreenBloc = SearchScreenBloc();
    _searchBarController = TextEditingController();

    _searchBarController.addListener(() {
      _searchScreenBloc.changeSearchText(_searchBarController.text);
    });
  }

  @override
  void dispose() {
    _searchScreenBloc.dispose();
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chromeutils.applySystemUIOverlayStyle();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      body: StreamBuilder<List<SearchSuggestion>>(
        stream: _searchScreenBloc.suggestions,
        builder: (context, snapshot) {
          return ScreenLayout(
            header: SearchHeaderDelegate(
              searchBarController: _searchBarController,
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
