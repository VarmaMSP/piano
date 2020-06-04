import 'package:flutter/material.dart';
import 'package:phenopod/screens/search/widgets/search_header_delegate.dart';
import 'package:phenopod/widgets/screen/layout.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      header: SearchHeaderDelegate(),
      body: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Text('this is the body'),
      ),
    );
  }
}
