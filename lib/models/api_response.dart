import 'package:piano/models/category.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/playlist.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/models/user.dart';

class ApiResponse {
  final List<User> users;
  final List<Podcast> podcasts;
  final List<Episode> episodes;
  final List<Playlist> playlists;
  final List<Category> categories;
  final SearchResults searchResults;

  ApiResponse({
    this.users,
    this.podcasts,
    this.episodes,
    this.playlists,
    this.categories,
    this.searchResults,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      users: (json['users'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => User.fromJson(d))
          ?.toList(),
      podcasts: (json['podcasts'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Podcast.fromJson(d))
          ?.toList(),
      episodes: (json['episodes'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Episode.fromJson(d))
          ?.toList(),
      playlists: (json['playlists'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Playlist.fromJson(d))
          ?.toList(),
      categories: (json['categories'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Category.fromJson(d))
          ?.toList(),
      searchResults: SearchResults.fromJson(
        (json['search_results'] as Map ?? {})?.cast<String, dynamic>(),
      ),
    );
  }
}

class SearchResults {
  final List<Podcast> podcasts;
  final List<Episode> episodes;

  SearchResults({
    this.podcasts,
    this.episodes,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      podcasts: (json['podcasts'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Podcast.fromJson(d))
          ?.toList(),
      episodes: (json['episodes'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => Episode.fromJson(d))
          ?.toList(),
    );
  }
}
