class Episode {
  final String id;
  final String urlParam;
  final String title;
  final String mediaUrl;
  final String pubDate;
  final String summary;
  final String description;
  final int duration;
  final int explicit;
  final int episode;
  final int season;
  final String type;
  final String titleHighlighted;
  final String descriptionHighlighted;
  final double progress;
  final String lastPlayedAt;

  Episode({
    this.id,
    this.urlParam,
    this.title,
    this.mediaUrl,
    this.pubDate,
    this.summary,
    this.description,
    this.duration,
    this.explicit,
    this.episode,
    this.season,
    this.type,
    this.titleHighlighted,
    this.descriptionHighlighted,
    this.progress,
    this.lastPlayedAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      urlParam: json['url_param'],
      title: json['title'],
      mediaUrl: json['media_url'],
      pubDate: json['pub_date'],
      summary: json['summary'],
      description: json['description'],
      duration: json['duration'],
      explicit: json['explicit'],
      episode: json['episode'],
      season: json['season'],
      type: json['type'],
      titleHighlighted: json['title_highlighted'],
      descriptionHighlighted: json['description_highlighted'],
      progress: json['progress'],
      lastPlayedAt: json['last_played_at'],
    );
  }
}
