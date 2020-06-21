// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'navigation_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class NavigateTo extends Equatable {
  const NavigateTo(this._type);

  factory NavigateTo.podcastPage({@required String urlParam}) = PodcastPage;

  final _NavigateTo _type;

//ignore: missing_return
  R when<R>({@required R Function(PodcastPage) podcastPage}) {
    assert(() {
      if (podcastPage == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _NavigateTo.PodcastPage:
        return podcastPage(this as PodcastPage);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(PodcastPage) podcastPage}) {
    assert(() {
      if (podcastPage == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _NavigateTo.PodcastPage:
        return podcastPage(this as PodcastPage);
    }
  }

  R whenOrElse<R>(
      {R Function(PodcastPage) podcastPage,
      @required R Function(NavigateTo) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _NavigateTo.PodcastPage:
        if (podcastPage == null) break;
        return podcastPage(this as PodcastPage);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(PodcastPage) podcastPage,
      @required FutureOr<R> Function(NavigateTo) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _NavigateTo.PodcastPage:
        if (podcastPage == null) break;
        return podcastPage(this as PodcastPage);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial({FutureOr<void> Function(PodcastPage) podcastPage}) {
    assert(() {
      if (podcastPage == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _NavigateTo.PodcastPage:
        if (podcastPage == null) break;
        return podcastPage(this as PodcastPage);
    }
  }

  @override
  List get props => const [];
}

@immutable
class PodcastPage extends NavigateTo {
  const PodcastPage({@required this.urlParam}) : super(_NavigateTo.PodcastPage);

  final String urlParam;

  @override
  String toString() => 'PodcastPage(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}
