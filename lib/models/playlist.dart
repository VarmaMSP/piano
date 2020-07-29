part of 'main.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Playlist extends Equatable {
  final String id;
  final String urlParam;
  final String userId;
  final String title;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: 'PUBLIC')
  final String privacy;

  @JsonKey(defaultValue: 0)
  final int episodeCount;

  @JsonKey(defaultValue: '')
  final String previewImage;

  @JsonKey(defaultValue: '')
  final String updatedAt;

  @JsonKey(defaultValue: <PlaylistMember>[])
  final List<PlaylistMember> members;

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
    return _$PlaylistFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlaylistToJson(this);
  }

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Playlist: { title: $title }';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaylistMember extends Equatable {
  final String episodeId;
  final int position;

  PlaylistMember({
    this.episodeId,
    this.position,
  });

  factory PlaylistMember.fromJson(Map<String, dynamic> json) {
    return _$PlaylistMemberFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlaylistMemberToJson(this);
  }

  @override
  List<Object> get props => [position];
}
