import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phenopod/blocs/subscription/subscription_bloc.dart';
import 'package:phenopod/models/episode.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:phenopod/utils/request.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc({
    @required this.urlParam,
    @required this.subscriptionBloc,
  }) {
    _subscription = subscriptionBloc.listen((state) {
      if (state is SubscribedToPodcast) {
        add(Subscribe(state.podcastId));
      }

      if (state is UnsubscribedToPodcast) {
        add(Unsubscribe(state.podcastId));
      }
    });
  }

  final String urlParam;
  final SubscriptionBloc subscriptionBloc;
  StreamSubscription<SubscriptionState> _subscription;

  @override
  PodcastState get initialState => PodcastInitial();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  @override
  Stream<PodcastState> mapEventToState(
    PodcastEvent event,
  ) async* {
    final state = this.state;

    try {
      // Load initial data
      if (event is Load && state is PodcastInitial) {
        final response = await makeRequest(
          method: 'GET',
          path: '/podcasts/$urlParam',
        );
        yield PodcastLoaded(
          podcast: response.podcasts[0],
          episodes: response.episodes,
          loadedAll: response.episodes.length < 15,
        );
      }

      // Load more episodes
      if (event is Load && state is PodcastLoaded && !state.loadedAll) {
        final response = await makeRequest(
          method: 'GET',
          path:
              '/ajax/browse?endpoint=podcast_episodes&&podcast_id=${state.podcast.id}&&offset=${state.episodes.length}&&limit=30&&order=pub_date_desc',
        );
        yield PodcastLoaded(
          podcast: state.podcast,
          episodes: state.episodes + response.episodes,
          loadedAll: response.episodes.length < 30,
        );
      }

      if (event is Subscribe &&
          state is PodcastLoaded &&
          event.podcastId == state.podcast.id) {
        yield PodcastLoaded(
          podcast: state.podcast.copyWith(isSubscribed: true),
          episodes: state.episodes,
          loadedAll: state.loadedAll,
        );
      }

      if (event is Unsubscribe &&
          state is PodcastLoaded &&
          event.podcastId == state.podcast.id) {
        yield PodcastLoaded(
          podcast: state.podcast.copyWith(isSubscribed: false),
          episodes: state.episodes,
          loadedAll: state.loadedAll,
        );
      }
    } catch (err) {
      yield PodcastError(errMsg: err.toString());
    }
  }
}
