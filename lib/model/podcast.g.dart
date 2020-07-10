// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'podcast.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PodcastCopyWithExtension on Podcast {
  Podcast copyWith({
    String author,
    String authorHighlighted,
    int complete,
    String copyright,
    String description,
    String descriptionHiglighted,
    String earliestEpisodePubDate,
    int explicit,
    String feedLastRefreshAt,
    String feedUrl,
    String id,
    bool isSubscribed,
    String language,
    String link,
    String summary,
    String title,
    String titleHighlighted,
    int totalEpisodes,
    int totalSeasons,
    String type,
    DateTime updatedAt,
    String urlParam,
  }) {
    return Podcast(
      author: author ?? this.author,
      authorHighlighted: authorHighlighted ?? this.authorHighlighted,
      complete: complete ?? this.complete,
      copyright: copyright ?? this.copyright,
      description: description ?? this.description,
      descriptionHiglighted:
          descriptionHiglighted ?? this.descriptionHiglighted,
      earliestEpisodePubDate:
          earliestEpisodePubDate ?? this.earliestEpisodePubDate,
      explicit: explicit ?? this.explicit,
      feedLastRefreshAt: feedLastRefreshAt ?? this.feedLastRefreshAt,
      feedUrl: feedUrl ?? this.feedUrl,
      id: id ?? this.id,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      language: language ?? this.language,
      link: link ?? this.link,
      summary: summary ?? this.summary,
      title: title ?? this.title,
      titleHighlighted: titleHighlighted ?? this.titleHighlighted,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      totalSeasons: totalSeasons ?? this.totalSeasons,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      urlParam: urlParam ?? this.urlParam,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) {
  return Podcast(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    title: json['title'] as String,
    summary: json['summary'] as String ?? '',
    description: json['description'] as String ?? '',
    language: json['language'] as String ?? '',
    explicit: json['explicit'] as int ?? 0,
    author: json['author'] as String ?? '',
    type: json['type'] as String ?? '',
    complete: json['complete'] as int ?? 0,
    link: json['link'] as String ?? '',
    copyright: json['copyright'] as String ?? '',
    totalEpisodes: json['total_episodes'] as int ?? 0,
    totalSeasons: json['total_seasons'] as int ?? 0,
    earliestEpisodePubDate: json['earliest_episode_pub_date'] as String ?? '',
    titleHighlighted: json['title_highlighted'] as String ?? '',
    authorHighlighted: json['author_highlighted'] as String ?? '',
    descriptionHiglighted: json['description_higlighted'] as String ?? '',
    feedUrl: json['feed_url'] as String ?? '',
    feedLastRefreshAt: json['feed_last_refresh_at'] as String ?? '',
    isSubscribed: json['is_subscribed'] as bool ?? false,
  );
}

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'title': instance.title,
      'summary': instance.summary,
      'description': instance.description,
      'language': instance.language,
      'explicit': instance.explicit,
      'author': instance.author,
      'type': instance.type,
      'complete': instance.complete,
      'link': instance.link,
      'copyright': instance.copyright,
      'total_episodes': instance.totalEpisodes,
      'total_seasons': instance.totalSeasons,
      'earliest_episode_pub_date': instance.earliestEpisodePubDate,
      'title_highlighted': instance.titleHighlighted,
      'author_highlighted': instance.authorHighlighted,
      'description_higlighted': instance.descriptionHiglighted,
      'feed_url': instance.feedUrl,
      'feed_last_refresh_at': instance.feedLastRefreshAt,
      'is_subscribed': instance.isSubscribed,
    };
