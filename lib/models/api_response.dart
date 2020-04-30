import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:piano/models/user.dart';

class ApiResponse {
  final List<User> users;
  final List<Podcast> podcasts;
  final List<Episode> episodes;

  ApiResponse({
    this.users,
    this.podcasts,
    this.episodes,
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
    );
  }
}
