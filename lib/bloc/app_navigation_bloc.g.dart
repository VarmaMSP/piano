// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'app_navigation_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Screen extends Equatable {
  const Screen(this._type);

  factory Screen.podcast({@required String urlParam}) = Podcast;

  final _Screen _type;

//ignore: missing_return
  R when<R>({@required R Function(Podcast) podcast}) {
    assert(() {
      if (podcast == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        return podcast(this as Podcast);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>({@required FutureOr<R> Function(Podcast) podcast}) {
    assert(() {
      if (podcast == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        return podcast(this as Podcast);
    }
  }

  R whenOrElse<R>(
      {R Function(Podcast) podcast, @required R Function(Screen) orElse}) {
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
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Podcast) podcast,
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
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial({FutureOr<void> Function(Podcast) podcast}) {
    assert(() {
      if (podcast == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Screen.Podcast:
        if (podcast == null) break;
        return podcast(this as Podcast);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Podcast extends Screen {
  const Podcast({@required this.urlParam}) : super(_Screen.Podcast);

  final String urlParam;

  @override
  String toString() => 'Podcast(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}
