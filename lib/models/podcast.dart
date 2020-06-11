import 'package:equatable/equatable.dart';

class Podcast extends Equatable {
  final String id;
  final String urlParam;
  final String title;
  final String summary;
  final String description;
  final String language;
  final bool explicit;
  final String author;
  final String type;
  final bool complete;
  final String link;
  final String copyright;
  final int totalEpisodes;
  final int totalSeasons;
  final String earliestEpisodePubDate;
  final String titleHighlighted;
  final String authorHighlighted;
  final String descriptionHiglighted;
  final String feedUrl;
  final String feedLastRefreshAt;
  final bool isSubscribed;

  const Podcast({
    this.id,
    this.urlParam,
    this.title,
    this.summary,
    this.description,
    this.language,
    this.explicit,
    this.author,
    this.type,
    this.complete,
    this.link,
    this.copyright,
    this.totalEpisodes,
    this.totalSeasons,
    this.earliestEpisodePubDate,
    this.titleHighlighted,
    this.authorHighlighted,
    this.descriptionHiglighted,
    this.feedUrl,
    this.feedLastRefreshAt,
    this.isSubscribed,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'],
      urlParam: json['url_param'],
      title: json['title'],
      summary: json['summary'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      explicit: json['explicit'] ?? false,
      author: json['author'] ?? '',
      type: json['type'] ?? '',
      complete: json['complete'] ?? false,
      link: json['link'] ?? '',
      copyright: json['copyright'] ?? '',
      totalEpisodes: json['total_episodes'] ?? 0,
      totalSeasons: json['total_seasons'] ?? 0,
      earliestEpisodePubDate: json['earliest_episode_pub_date'] ?? '',
      titleHighlighted: json['title_highlighted'] ?? '',
      authorHighlighted: json['author_highlighted'] ?? '',
      descriptionHiglighted: json['description_highlighted'] ?? '',
      feedUrl: json['feed_url'] ?? '',
      feedLastRefreshAt: json['feed_last_refresh_at'] ?? '',
      isSubscribed: json['is_subscribed'] ?? false,
    );
  }

  Podcast copyWith({
    String id,
    String urlParam,
    String title,
    String summary,
    String description,
    String language,
    bool explicit,
    String author,
    String type,
    bool complete,
    String link,
    String copyright,
    int totalEpisodes,
    int totalSeasons,
    String earliestEpisodePubDate,
    String titleHighlighted,
    String authorHighlighted,
    String descriptionHiglighted,
    String feedUrl,
    String feedLastRefreshAt,
    bool isSubscribed,
  }) {
    return Podcast(
      id: id ?? this.id,
      urlParam: urlParam ?? this.urlParam,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      language: language ?? this.language,
      explicit: explicit ?? this.explicit,
      author: author ?? this.author,
      type: type ?? this.type,
      complete: complete ?? this.complete,
      link: link ?? this.link,
      copyright: copyright ?? this.copyright,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      totalSeasons: totalSeasons ?? this.totalSeasons,
      earliestEpisodePubDate:
          earliestEpisodePubDate ?? this.earliestEpisodePubDate,
      titleHighlighted: titleHighlighted ?? this.titleHighlighted,
      authorHighlighted: authorHighlighted ?? this.authorHighlighted,
      descriptionHiglighted:
          descriptionHiglighted ?? this.descriptionHiglighted,
      feedUrl: feedUrl ?? this.feedUrl,
      feedLastRefreshAt: feedLastRefreshAt ?? this.feedLastRefreshAt,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }

  @override
  List<Object> get props => [id, isSubscribed];

  @override
  String toString() => 'Podcast: { id: $id }';
}
