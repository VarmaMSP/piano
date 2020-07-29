// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'main.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EpisodeCopyWithExtension on Episode {
  Episode copyWith({
    String description,
    String descriptionHighlighted,
    int duration,
    int episode,
    int explicit,
    String id,
    String lastPlayedAt,
    String mediaUrl,
    String podcastId,
    double progress,
    DateTime pubDate,
    int season,
    String summary,
    String title,
    String titleHighlighted,
    String type,
    String urlParam,
  }) {
    return Episode(
      description: description ?? this.description,
      descriptionHighlighted:
          descriptionHighlighted ?? this.descriptionHighlighted,
      duration: duration ?? this.duration,
      episode: episode ?? this.episode,
      explicit: explicit ?? this.explicit,
      id: id ?? this.id,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      podcastId: podcastId ?? this.podcastId,
      progress: progress ?? this.progress,
      pubDate: pubDate ?? this.pubDate,
      season: season ?? this.season,
      summary: summary ?? this.summary,
      title: title ?? this.title,
      titleHighlighted: titleHighlighted ?? this.titleHighlighted,
      type: type ?? this.type,
      urlParam: urlParam ?? this.urlParam,
    );
  }
}

extension PlaybackPositionCopyWithExtension on PlaybackPosition {
  PlaybackPosition copyWith({
    Duration duration,
    String episodeId,
    double percentage,
    Duration position,
    DateTime updatedAt,
  }) {
    return PlaybackPosition(
      duration: duration ?? this.duration,
      episodeId: episodeId ?? this.episodeId,
      percentage: percentage ?? this.percentage,
      position: position ?? this.position,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension PodcastCopyWithExtension on Podcast {
  Podcast copyWith({
    String author,
    String authorHighlighted,
    DateTime cacheUpdatedAt,
    bool cachedAllEpisodes,
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
    String urlParam,
  }) {
    return Podcast(
      author: author ?? this.author,
      authorHighlighted: authorHighlighted ?? this.authorHighlighted,
      cacheUpdatedAt: cacheUpdatedAt ?? this.cacheUpdatedAt,
      cachedAllEpisodes: cachedAllEpisodes ?? this.cachedAllEpisodes,
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
      urlParam: urlParam ?? this.urlParam,
    );
  }
}

extension QueueCopyWithExtension on Queue {
  Queue copyWith({
    List<AudioTrack> audioTracks,
    int position,
  }) {
    return Queue(
      audioTracks: audioTracks ?? this.audioTracks,
      position: position ?? this.position,
    );
  }
}

extension AudioTrackCopyWithExtension on AudioTrack {
  AudioTrack copyWith({
    Episode episode,
    Podcast podcast,
    int position,
  }) {
    return AudioTrack(
      episode: episode ?? this.episode,
      podcast: podcast ?? this.podcast,
      position: position ?? this.position,
    );
  }
}

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

extension EpisodeScreenDataCopyWithExtension on EpisodeScreenData {
  EpisodeScreenData copyWith({
    Episode episode,
    EpisodeMeta episodeMeta,
    bool isPodcastSubscribed,
    Podcast podcast,
  }) {
    return EpisodeScreenData(
      episode: episode ?? this.episode,
      episodeMeta: episodeMeta ?? this.episodeMeta,
      isPodcastSubscribed: isPodcastSubscribed ?? this.isPodcastSubscribed,
      podcast: podcast ?? this.podcast,
    );
  }
}

extension SubscriptionsScreenDataCopyWithExtension on SubscriptionsScreenData {
  SubscriptionsScreenData copyWith({
    List<FeedItem> feedItems,
    List<Podcast> podcasts,
    bool receivedAllEpisodes,
  }) {
    return SubscriptionsScreenData(
      feedItems: feedItems ?? this.feedItems,
      podcasts: podcasts ?? this.podcasts,
      receivedAllEpisodes: receivedAllEpisodes ?? this.receivedAllEpisodes,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueDetails _$_$QueueDetailsFromJson(Map<String, dynamic> json) {
  return _$QueueDetails(
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$_$QueueDetailsToJson(_$QueueDetails instance) =>
    <String, dynamic>{
      'position': instance.position,
    };

_$SubscriptionsRefreshDetails _$_$SubscriptionsRefreshDetailsFromJson(
    Map<String, dynamic> json) {
  return _$SubscriptionsRefreshDetails(
    lastRefreshedAt: json['lastRefreshedAt'] == null
        ? null
        : DateTime.parse(json['lastRefreshedAt'] as String),
  );
}

Map<String, dynamic> _$_$SubscriptionsRefreshDetailsToJson(
        _$SubscriptionsRefreshDetails instance) =>
    <String, dynamic>{
      'lastRefreshedAt': instance.lastRefreshedAt?.toIso8601String(),
    };

_$AudioPlayerSetting _$_$AudioPlayerSettingFromJson(Map<String, dynamic> json) {
  return _$AudioPlayerSetting(
    seekForwardTime: json['seekForwardTime'] as int,
    seekBackwardTime: json['seekBackwardTime'] as int,
  );
}

Map<String, dynamic> _$_$AudioPlayerSettingToJson(
        _$AudioPlayerSetting instance) =>
    <String, dynamic>{
      'seekForwardTime': instance.seekForwardTime,
      'seekBackwardTime': instance.seekBackwardTime,
    };

_$StorageSetting _$_$StorageSettingFromJson(Map<String, dynamic> json) {
  return _$StorageSetting(
    storage: _$enumDecodeNullable(_$StorageEnumMap, json['storage']),
    storagePath: json['storagePath'] as String,
  );
}

Map<String, dynamic> _$_$StorageSettingToJson(_$StorageSetting instance) =>
    <String, dynamic>{
      'storage': _$StorageEnumMap[instance.storage],
      'storagePath': instance.storagePath,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StorageEnumMap = {
  Storage.none: 'none',
  Storage.internalStorage: 'internalStorage',
  Storage.externalStorage: 'externalStorage',
};

_$_CachePodcast _$_$_CachePodcastFromJson(Map<String, dynamic> json) {
  return _$_CachePodcast(
    podcastId: json['podcastId'] as String,
    podcastUrlParam: json['podcastUrlParam'] as String,
  );
}

Map<String, dynamic> _$_$_CachePodcastToJson(_$_CachePodcast instance) =>
    <String, dynamic>{
      'podcastId': instance.podcastId,
      'podcastUrlParam': instance.podcastUrlParam,
    };

_$_DownloadEpisode _$_$_DownloadEpisodeFromJson(Map<String, dynamic> json) {
  return _$_DownloadEpisode(
    episodeId: json['episodeId'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
    storagePath: json['storagePath'] as String,
  );
}

Map<String, dynamic> _$_$_DownloadEpisodeToJson(_$_DownloadEpisode instance) =>
    <String, dynamic>{
      'episodeId': instance.episodeId,
      'url': instance.url,
      'filename': instance.filename,
      'storagePath': instance.storagePath,
    };

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    podcasts: (json['podcasts'] as List)
            ?.map((e) =>
                e == null ? null : Podcast.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    episodes: (json['episodes'] as List)
            ?.map((e) =>
                e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    users: (json['users'] as List)
            ?.map((e) =>
                e == null ? null : User.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    playlists: (json['playlists'] as List)
            ?.map((e) =>
                e == null ? null : Playlist.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    categories: (json['categories'] as List)
            ?.map((e) =>
                e == null ? null : Category.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    searchSuggestions: (json['search_suggestions'] as List)
            ?.map((e) => e == null
                ? null
                : SearchSuggestion.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    searchResults: json['search_results'] == null
        ? null
        : SearchResults.fromJson(
                json['search_results'] as Map<String, dynamic>) ??
            [],
  )..raw = json['raw'];
}

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) {
  return SearchResults(
    podcasts: (json['podcasts'] as List)
            ?.map((e) =>
                e == null ? null : Podcast.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    episodes: (json['episodes'] as List)
            ?.map((e) =>
                e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    name: json['name'] as String,
    parentId: json['parent_id'] as String ?? '',
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'name': instance.name,
      'parent_id': instance.parentId,
    };

Curation _$CurationFromJson(Map<String, dynamic> json) {
  return Curation(
    id: json['id'] as String,
    title: json['title'] as String,
    podcasts: (json['podcasts'] as List)
        ?.map((e) =>
            e == null ? null : Podcast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CurationToJson(Curation instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'podcasts': instance.podcasts,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    title: json['title'] as String,
    mediaUrl: json['media_url'] as String,
    podcastId: json['podcast_id'] as String ?? '',
    pubDate: parseDateTime(json['pub_date'] as String),
    summary: json['summary'] as String ?? '',
    description: json['description'] as String ?? '',
    duration: json['duration'] as int ?? 0,
    explicit: json['explicit'] as int ?? 0,
    episode: json['episode'] as int ?? 0,
    season: json['season'] as int ?? 0,
    type: json['type'] as String ?? '',
    titleHighlighted: json['title_highlighted'] as String ?? '',
    descriptionHighlighted: json['description_highlighted'] as String ?? '',
    progress: (json['progress'] as num)?.toDouble() ?? 0.0,
    lastPlayedAt: json['last_played_at'] as String ?? '',
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'title': instance.title,
      'media_url': instance.mediaUrl,
      'podcast_id': instance.podcastId,
      'pub_date': instance.pubDate?.toIso8601String(),
      'summary': instance.summary,
      'description': instance.description,
      'duration': instance.duration,
      'explicit': instance.explicit,
      'episode': instance.episode,
      'season': instance.season,
      'type': instance.type,
      'title_highlighted': instance.titleHighlighted,
      'description_highlighted': instance.descriptionHighlighted,
      'progress': instance.progress,
      'last_played_at': instance.lastPlayedAt,
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String ?? '',
    privacy: json['privacy'] as String ?? 'PUBLIC',
    episodeCount: json['episode_count'] as int ?? 0,
    previewImage: json['preview_image'] as String ?? '',
    updatedAt: json['updated_at'] as String ?? '',
    members: (json['members'] as List)
            ?.map((e) => e == null
                ? null
                : PlaylistMember.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'privacy': instance.privacy,
      'episode_count': instance.episodeCount,
      'preview_image': instance.previewImage,
      'updated_at': instance.updatedAt,
      'members': instance.members,
    };

PlaylistMember _$PlaylistMemberFromJson(Map<String, dynamic> json) {
  return PlaylistMember(
    episodeId: json['episode_id'] as String,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$PlaylistMemberToJson(PlaylistMember instance) =>
    <String, dynamic>{
      'episode_id': instance.episodeId,
      'position': instance.position,
    };

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

SearchSuggestion _$SearchSuggestionFromJson(Map<String, dynamic> json) {
  return SearchSuggestion(
    t: json['t'] as String ?? 'T',
    i: json['i'] as String ?? 'S',
    header: json['h1'] as String ?? '',
    subHeader: json['h2'] as String ?? '',
  );
}

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String ?? '',
  );
}

GuestCredentials _$GuestCredentialsFromJson(Map<String, dynamic> json) {
  return GuestCredentials(
    id: json['id'] as String,
    deviceUuid: json['device_uuid'] as String,
    deviceOs: json['device_os'] as String,
    deviceModel: json['device_model'] as String,
  );
}

Map<String, dynamic> _$GuestCredentialsToJson(GuestCredentials instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_uuid': instance.deviceUuid,
      'device_os': instance.deviceOs,
      'device_model': instance.deviceModel,
    };
