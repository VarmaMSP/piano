// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, cast_to_non_type, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
