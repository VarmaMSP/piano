import 'package:equatable/equatable.dart';

class Podcast extends Equatable {
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
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'] as String,
      urlParam: json['url_param'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String ?? '',
      description: json['description'] as String ?? '',
      language: json['language'] as String ?? '',
      explicit: json['explicit'] as bool ?? false,
      author: json['author'] as String ?? '',
      type: json['type'] as String ?? '',
      complete: json['complete'] as bool ?? false,
      link: json['link'] as String ?? '',
      copyright: json['copyright'] as String ?? '',
      totalEpisodes: json['total_episodes'] as int ?? 0,
      totalSeasons: json['total_seasons'] as int ?? 0,
      earliestEpisodePubDate: json['earliest_episode_pub_date'] as String ?? '',
      titleHighlighted: json['title_highlighted'] as String ?? '',
      authorHighlighted: json['author_highlighted'] as String ?? '',
      descriptionHiglighted: json['description_highlighted'] as String ?? '',
      feedUrl: json['feed_url'] as String ?? '',
      feedLastRefreshAt: json['feed_last_refresh_at'] as String ?? '',
    );
  }

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

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Podcast: { id: $id }';
}
