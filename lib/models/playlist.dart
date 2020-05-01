class Playlist {
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

  Playlist({
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
      id: json['id'],
      urlParam: json['url_param'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      privacy: json['privacy'],
      episodeCount: json['episode_count'],
      previewImage: json['preview_image'],
      updatedAt: json['updated_at'],
      members: (json['members'] as List)
          ?.cast<Map<String, dynamic>>()
          ?.map((d) => PlaylistMember.fromJson(d))
          ?.toList(),
    );
  }
}

class PlaylistMember {
  final String episodeId;
  final int position;

  PlaylistMember({
    this.episodeId,
    this.position,
  });

  factory PlaylistMember.fromJson(Map<String, dynamic> json) {
    return PlaylistMember(
      episodeId: json['episode_id'],
      position: json['position'],
    );
  }
}
