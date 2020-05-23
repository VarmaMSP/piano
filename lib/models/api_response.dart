import 'package:phenopod/models/category.dart';
import 'package:phenopod/models/episode.dart';
import 'package:phenopod/models/playlist.dart';
import 'package:phenopod/models/podcast.dart';
import 'package:phenopod/models/user.dart';

class ApiResponse {
  ApiResponse({
    this.users,
    this.podcasts,
    this.episodes,
    this.playlists,
    this.categories,
    this.searchResults,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return ApiResponse(
      users: (data['users'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => User.fromJson(d))
          .toList(),
      podcasts: (data['podcasts'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Podcast.fromJson(d))
          .toList(),
      episodes: (data['episodes'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Episode.fromJson(d))
          .toList(),
      playlists: (data['playlists'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Playlist.fromJson(d))
          .toList(),
      categories: (data['categories'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Category.fromJson(d))
          .toList(),
      searchResults: SearchResults.fromJson(
        (data['search_results'] as Map<dynamic, dynamic> ??
                <dynamic, dynamic>{})
            .cast<String, dynamic>(),
      ),
    );
  }

  final List<User> users;
  final List<Podcast> podcasts;
  final List<Episode> episodes;
  final List<Playlist> playlists;
  final List<Category> categories;
  final SearchResults searchResults;
}

class SearchResults {
  SearchResults({
    this.podcasts,
    this.episodes,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      podcasts: (json['podcasts'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Podcast.fromJson(d))
          .toList(),
      episodes: (json['episodes'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => Episode.fromJson(d))
          .toList(),
    );
  }

  final List<Podcast> podcasts;
  final List<Episode> episodes;
}
