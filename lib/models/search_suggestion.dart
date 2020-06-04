import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const String typeText = 'T';
const String typePodcast = 'P';
const String iconSearch = 'S';
const String iconHistory = 'H';
const String iconCurrent = 'C';

class SearchSuggestion extends Equatable {
  static bool isPodcast(SearchSuggestion suggestion) {
    return suggestion.t == typePodcast;
  }

  SearchSuggestion({
    this.id,
    this.t,
    this.i,
    this.header,
    this.subHeader,
  });

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) {
    return SearchSuggestion(
      id: Uuid().v1(),
      t: json['t'] ?? typeText,
      i: json['i'] ?? iconSearch,
      header: json['h1'] ?? '',
      subHeader: json['h2'] ?? '',
    );
  }

  final String id;
  final String t;
  final String i;
  final String header;
  final String subHeader;

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'SearchSuggestion: { text: $header }';
}
