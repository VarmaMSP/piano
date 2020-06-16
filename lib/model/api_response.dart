import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'episode.dart';
import 'playlist.dart';
import 'podcast.dart';
import 'user.dart';
import 'search_suggestion.dart';

part 'api_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ApiResponse {
  @JsonKey(defaultValue: [])
  final List<Podcast> podcasts;

  @JsonKey(defaultValue: [])
  final List<Episode> episodes;

  @JsonKey(defaultValue: [])
  final List<User> users;

  @JsonKey(defaultValue: [])
  final List<Playlist> playlists;

  @JsonKey(defaultValue: [])
  final List<Category> categories;

  @JsonKey(defaultValue: [])
  final List<SearchSuggestion> searchSuggestions;

  @JsonKey(defaultValue: [])
  final SearchResults searchResults;

  final dynamic raw;

  const ApiResponse({
    this.podcasts,
    this.episodes,
    this.users,
    this.playlists,
    this.categories,
    this.searchSuggestions,
    this.searchResults,
    this.raw,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return _$ApiResponseFromJson(json);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class SearchResults {
  @JsonKey(defaultValue: [])
  final List<Podcast> podcasts;

  @JsonKey(defaultValue: [])
  final List<Episode> episodes;

  SearchResults({
    this.podcasts,
    this.episodes,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return _$SearchResultsFromJson(json);
  }
}
