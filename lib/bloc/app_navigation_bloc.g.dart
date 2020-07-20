// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'app_navigation_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Screen extends Equatable {
  const Screen(this._type);

  factory Screen.podcast(
      {@required String urlParam,
      @required String title,
      @required String author}) = Podcast;

  factory Screen.downloads() = Downloads;

  final _Screen _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Podcast) podcast,
      @required R Function(Downloads) downloads}) {
    assert(() {
      if (podcast == null || downloads == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        return podcast(this as Podcast);
      case _Screen.Downloads:
        return downloads(this as Downloads);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Podcast) podcast,
      @required FutureOr<R> Function(Downloads) downloads}) {
    assert(() {
      if (podcast == null || downloads == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        return podcast(this as Podcast);
      case _Screen.Downloads:
        return downloads(this as Downloads);
    }
  }

  R whenOrElse<R>(
      {R Function(Podcast) podcast,
      R Function(Downloads) downloads,
      @required R Function(Screen) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        if (podcast == null) break;
        return podcast(this as Podcast);
      case _Screen.Downloads:
        if (downloads == null) break;
        return downloads(this as Downloads);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Podcast) podcast,
      FutureOr<R> Function(Downloads) downloads,
      @required FutureOr<R> Function(Screen) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        if (podcast == null) break;
        return podcast(this as Podcast);
      case _Screen.Downloads:
        if (downloads == null) break;
        return downloads(this as Downloads);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Podcast) podcast,
      FutureOr<void> Function(Downloads) downloads}) {
    assert(() {
      if (podcast == null && downloads == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        if (podcast == null) break;
        return podcast(this as Podcast);
      case _Screen.Downloads:
        if (downloads == null) break;
        return downloads(this as Downloads);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Podcast extends Screen {
  const Podcast(
      {@required this.urlParam, @required this.title, @required this.author})
      : super(_Screen.Podcast);

  final String urlParam;

  final String title;

  final String author;

  @override
  String toString() =>
      'Podcast(urlParam:${this.urlParam},title:${this.title},author:${this.author})';
  @override
  List get props => [urlParam, title, author];
}

@immutable
class Downloads extends Screen {
  const Downloads._() : super(_Screen.Downloads);

  factory Downloads() {
    _instance ??= const Downloads._();
    return _instance;
  }

  static Downloads _instance;
}
