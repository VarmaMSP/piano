import 'package:phenopod/models/search_suggestion.dart';

import 'category.dart';
import 'curation.dart';
import 'episode.dart';
import 'playlist.dart';
import 'podcast.dart';
import 'user.dart';

class ApiResponse {
  ApiResponse({
    this.users,
    this.podcasts,
    this.episodes,
    this.playlists,
    this.categories,
    this.searchSuggestions,
    this.searchResults,
    this.raw,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return ApiResponse(
      users: (data['users'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => User.fromJson(d))
          .toList(),
      podcasts: (data['podcasts'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Podcast.fromJson(d))
          .toList(),
      episodes: (data['episodes'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Episode.fromJson(d))
          .toList(),
      playlists: (data['playlists'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Playlist.fromJson(d))
          .toList(),
      categories: (data['categories'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Category.fromJson(d))
          .toList(),
      searchSuggestions: (data['search_suggestions'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => SearchSuggestion.fromJson(d))
          .toList(),
      searchResults: SearchResults.fromJson(
        (data['search_results'] as Map ?? {}).cast<String, dynamic>(),
      ),
      raw: json['raw'],
    );
  }

  final List<User> users;
  final List<Podcast> podcasts;
  final List<Episode> episodes;
  final List<Playlist> playlists;
  final List<Category> categories;
  final List<SearchSuggestion> searchSuggestions;
  final SearchResults searchResults;
  final dynamic raw;

  List<Curation> get curations => (raw as List ?? [])
      .cast<Map<String, dynamic>>()
      .map((d) => Curation.fromJson(d))
      .toList();

  List<Category> get primaryCategories =>
      categories.where((c) => c.parentId == '').toList();
}

class SearchResults {
  SearchResults({
    this.podcasts,
    this.episodes,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      podcasts: (json['podcasts'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Podcast.fromJson(d))
          .toList(),
      episodes: (json['episodes'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Episode.fromJson(d))
          .toList(),
    );
  }

  final List<Podcast> podcasts;
  final List<Episode> episodes;
}
