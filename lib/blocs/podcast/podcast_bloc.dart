import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/models/episode.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:phenopod/utils/request.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc({
    @required this.urlParam,
    @required this.request,
  });

  final String urlParam;
  final Request request;

  @override
  PodcastState get initialState => PodcastInitial();

  @override
  Stream<PodcastState> mapEventToState(
    PodcastEvent event,
  ) async* {
    final state = this.state;

    try {
      // Load initial data
      if (event is Load && state is PodcastInitial) {
        final response = await request.get('/podcasts/$urlParam');
        yield PodcastLoaded(
          podcast: response.podcasts[0],
          episodes: response.episodes,
          loadedAll: response.episodes.length < 15,
        );
      }

      // Load more episodes
      if (event is Load && state is PodcastLoaded && !state.loadedAll) {
        final response = await request.get(
            '/ajax/browse?endpoint=podcast_episodes&&podcast_id=${state.podcast.id}&&offset=${state.episodes.length}&&limit=30&&order=pub_date_desc');
        yield PodcastLoaded(
          podcast: state.podcast,
          episodes: state.episodes + response.episodes,
          loadedAll: response.episodes.length < 30,
        );
      }
    } catch (err) {
      yield PodcastError(errMsg: err.toString());
    }
  }
}
