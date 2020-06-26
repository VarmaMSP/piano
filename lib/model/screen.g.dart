// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'screen.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PodcastScreenDataCopyWithExtension on PodcastScreenData {
  PodcastScreenData copyWith({
    List<Episode> episodes,
    Podcast podcast,
    bool receivedAllEpisodes,
  }) {
    return PodcastScreenData(
      episodes: episodes ?? this.episodes,
      podcast: podcast ?? this.podcast,
      receivedAllEpisodes: receivedAllEpisodes ?? this.receivedAllEpisodes,
    );
  }
}

extension SubscriptionsScreenDataCopyWithExtension on SubscriptionsScreenData {
  SubscriptionsScreenData copyWith({
    List<Episode> episodes,
    Map<String, Podcast> podcastById,
  }) {
    return SubscriptionsScreenData(
      episodes: episodes ?? this.episodes,
      podcastById: podcastById ?? this.podcastById,
    );
  }
}