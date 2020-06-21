import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'search_suggestion.g.dart';

const String typeText = 'T';
const String typePodcast = 'P';
const String iconSearch = 'S';
const String iconHistory = 'H';
const String iconCurrent = 'C';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class SearchSuggestion extends Equatable {
  static bool isPodcast(SearchSuggestion suggestion) {
    return suggestion.t == typePodcast;
  }

  @JsonKey(ignore: true)
  final String id = Uuid().v1();

  @JsonKey(defaultValue: typeText)
  final String t;

  @JsonKey(defaultValue: iconSearch)
  final String i;

  @JsonKey(defaultValue: '', name: 'h1')
  final String header;

  @JsonKey(defaultValue: '', name: 'h2')
  final String subHeader;

  SearchSuggestion({
    this.t,
    this.i,
    this.header,
    this.subHeader,
  });

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) {
    return _$SearchSuggestionFromJson(json);
  }

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'SearchSuggestion: { text: $header }';
}
