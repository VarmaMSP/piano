import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/episodes/episodes_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodesBloc, EpisodesState>(
      builder: (context, state) {
        if (state is EpisodesInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is EpisodeLoaded) {
          if (state.episodes.isEmpty) {
            return Center(
              child: Text('no episodes'),
            );
          }

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  '${state.episodes[index].id}',
                  style: TextStyle(fontSize: 10.0),
                ),
                title: Text(state.episodes[index].title),
                isThreeLine: true,
                subtitle: Text(state.episodes[index].summary),
                dense: true,
              );
            },
            itemCount: state.episodes.length,
          );
        }

        return Center(
          child: Text((state as EpisodesError).errMsg),
        );
      },
    );
  }
}
