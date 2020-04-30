class Podcast {
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

  Podcast({
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
      id: json['id'],
      urlParam: json['url_param'],
      title: json['title'],
      summary: json['summary'],
      description: json['description'],
      language: json['language'],
      explicit: json['explicit'],
      author: json['author'],
      type: json['type'],
      complete: json['complete'],
      link: json['link'],
      copyright: json['copyright'],
      totalEpisodes: json['total_episodes'],
      totalSeasons: json['total_seasons'],
      earliestEpisodePubDate: json['earliest_episode_pub_date'],
      titleHighlighted: json['title_highlighted'],
      authorHighlighted: json['author_highlighted'],
      descriptionHiglighted: json['description_highlighted'],
      feedUrl: json['feed_url'],
      feedLastRefreshAt: json['feed_last_refresh_at'],
    );
  }
}
