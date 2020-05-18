import 'package:equatable/equatable.dart';

class Playlist extends Equatable {
  const Playlist({
    this.id,
    this.urlParam,
    this.userId,
    this.title,
    this.description,
    this.privacy,
    this.episodeCount,
    this.previewImage,
    this.updatedAt,
    this.members,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
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
      members: (json['members'] as List<dynamic> ?? <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> d) => PlaylistMember.fromJson(d))
          .toList(),
    );
  }

  final String id;
  final String urlParam;
  final String userId;
  final String title;
  final String description;
  final String privacy;
  final int episodeCount;
  final String previewImage;
  final String updatedAt;
  final List<PlaylistMember> members;

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Playlist: { id: $id }';
}

class PlaylistMember {
  PlaylistMember({
    this.episodeId,
    this.position,
  });

  factory PlaylistMember.fromJson(Map<String, dynamic> json) {
    return PlaylistMember(
      episodeId: json['episode_id'] as String,
      position: json['position'] as int,
    );
  }

  final String episodeId;
  final int position;
}
