import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/utils/request.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final String urlParam;
  final Request request;

  PodcastBloc({
    @required this.urlParam,
    @required this.request,
  });

  @override
  PodcastState get initialState => PodcastInitial();

  @override
  Stream<Transition<PodcastEvent, PodcastState>> transformEvents(
    Stream<PodcastEvent> events,
    TransitionFunction<PodcastEvent, PodcastState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PodcastState> mapEventToState(
    PodcastEvent event,
  ) async* {
    final PodcastState state = this.state;

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
