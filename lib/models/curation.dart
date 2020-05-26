import 'package:equatable/equatable.dart';

import 'podcast.dart';

class Curation extends Equatable {
  const Curation({
    this.id,
    this.title,
    this.podcasts,
  });

  factory Curation.fromJson(Map<String, dynamic> json) {
    return Curation(
      id: json['title'],
      title: json['title'],
      podcasts: (json['podcasts'] as List ?? [])
          .cast<Map<String, dynamic>>()
          .map((d) => Podcast.fromJson(d))
          .toList(),
    );
  }

  final String id;
  final String title;
  final List<Podcast> podcasts;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Curation: { id: $id }';
}
