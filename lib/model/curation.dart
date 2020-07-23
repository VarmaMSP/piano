part of 'main.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Curation extends Equatable {
  final String id;
  final String title;
  final List<Podcast> podcasts;

  const Curation({
    this.id,
    this.title,
    this.podcasts,
  });

  factory Curation.fromJson(Map<String, dynamic> json) {
    return _$CurationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CurationToJson(this);
  }

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Curation: { id: $id }';
}
