import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/utils/request.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final Request request;

  EpisodesBloc({
    @required this.request,
  });

  @override
  EpisodesState get initialState => EpisodesInitial();

  @override
  Stream<EpisodesState> mapEventToState(
    EpisodesEvent event,
  ) async* {
    if (event is Fetch) {
      try {
        if (state is EpisodesInitial) {
          final response = await request
              .get('/podcasts/making-sense-with-sam-harris-e36k4d');

          stderr.writeln(response);
          yield EpisodeLoaded(episodes: response.episodes);
        }
      } catch (err) {
        yield EpisodesError(errMsg: err.toString());
      }
    }
  }
}
