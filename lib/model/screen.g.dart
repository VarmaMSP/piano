// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'screen.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PodcastScreenDataCopyWithExtension on PodcastScreenData {
  PodcastScreenData copyWith({
    List<Episode> episodes,
    bool isSubscribed,
    Podcast podcast,
    bool receivedAllEpisodes,
  }) {
    return PodcastScreenData(
      episodes: episodes ?? this.episodes,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      podcast: podcast ?? this.podcast,
      receivedAllEpisodes: receivedAllEpisodes ?? this.receivedAllEpisodes,
    );
  }
}

extension SubscriptionScreenDataCopyWithExtension on SubscriptionScreenData {
  SubscriptionScreenData copyWith({
    List<Episode> episodes,
    List<Podcast> subscriptions,
  }) {
    return SubscriptionScreenData(
      episodes: episodes ?? this.episodes,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }
}
