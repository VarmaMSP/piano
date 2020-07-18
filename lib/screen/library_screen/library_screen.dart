import 'package:flutter/material.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppNavigationBloc>(context, listen: false)
            .pushScreen(Screen.downloads());
      },
      child: Text('Downloads Page'),
    );
  }
}
