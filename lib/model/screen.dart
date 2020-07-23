part of 'main.dart';

enum AppTab {
  homeTab,
  subscriptionsTab,
  libraryTab,
}

@freezed
abstract class AppScreen with _$AppScreen {
  const factory AppScreen.podcastScreen({
    @required String urlParam,
    @required String title,
    @required String author,
  }) = _PodcastScreen;

  const factory AppScreen.downloadsScreen() = _DownloadsScreen;
}

class FeedItem extends Equatable {
  final Episode episode;
  final Podcast podcast;

  FeedItem({this.episode, this.podcast});

  @override
  List<Object> get props => [episode, podcast];
}

@CopyWith()
class PodcastScreenData extends Equatable {
  final Podcast podcast;
  final List<Episode> episodes;
  final bool isSubscribed;
  final bool receivedAllEpisodes;

  PodcastScreenData({
    @required this.podcast,
    @required this.episodes,
    @required this.isSubscribed,
    @required this.receivedAllEpisodes,
  });

  @override
  List<Object> get props => [
        podcast,
        episodes,
        isSubscribed,
        receivedAllEpisodes,
      ];
}

@CopyWith()
class SubscriptionsScreenData extends Equatable {
  final List<Podcast> podcasts;
  final List<FeedItem> feedItems;
  final bool receivedAllEpisodes;

  SubscriptionsScreenData({
    @required this.podcasts,
    @required this.feedItems,
    @required this.receivedAllEpisodes,
  });

  @override
  List<Object> get props => [
        podcasts,
        feedItems,
        receivedAllEpisodes,
      ];
}
