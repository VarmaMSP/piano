import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/screens/search/bloc/search_suggestions_bloc.dart';
import 'package:phenopod/screens/search/widgets/search_header_delegate.dart';
import 'package:phenopod/screens/search/widgets/suggestions_list.dart';
import 'package:phenopod/widgets/screen/layout.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchSuggestionsBloc _searchSuggestionsBloc;
  TextEditingController _searchBarController;

  @override
  void initState() {
    super.initState();
    _searchSuggestionsBloc = SearchSuggestionsBloc();
    _searchBarController = TextEditingController();

    _searchBarController.addListener(() {
      _searchSuggestionsBloc.add(
        SearchTextUpdated(searchText: _searchBarController.text),
      );
    });
  }

  @override
  void dispose() {
    _searchSuggestionsBloc.close();
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchSuggestionsBloc, SearchSuggestionsState>(
      bloc: _searchSuggestionsBloc,
      builder: (context, state) {
        return ScreenLayout(
          header: SearchHeaderDelegate(
            searchBarController: _searchBarController,
          ),
          body: state is SearchSuggestionsLoaded
              ? SuggestionsList(suggestions: state.suggestions)
              : Container(
                  color: Colors.white,
                  constraints: BoxConstraints.expand(),
                  child:
                      Text('Search for podcasts, episodes, topics, person...'),
                ),
        );
      },
    );
  }
}
