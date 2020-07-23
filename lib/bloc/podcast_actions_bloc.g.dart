// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'podcast_actions_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PodcastAction extends Equatable {
  const PodcastAction(this._type);

  factory PodcastAction.subscribe({@required Podcast podcast}) = Subscribe;

  factory PodcastAction.unsubscribe({@required Podcast podcast}) = Unsubscribe;

  final _PodcastAction _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Subscribe) subscribe,
      @required R Function(Unsubscribe) unsubscribe}) {
    assert(() {
      if (subscribe == null || unsubscribe == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribe:
        return subscribe(this as Subscribe);
      case _PodcastAction.Unsubscribe:
        return unsubscribe(this as Unsubscribe);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Subscribe) subscribe,
      @required FutureOr<R> Function(Unsubscribe) unsubscribe}) {
    assert(() {
      if (subscribe == null || unsubscribe == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribe:
        return subscribe(this as Subscribe);
      case _PodcastAction.Unsubscribe:
        return unsubscribe(this as Unsubscribe);
    }
  }

  R whenOrElse<R>(
      {R Function(Subscribe) subscribe,
      R Function(Unsubscribe) unsubscribe,
      @required R Function(PodcastAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _PodcastAction.Unsubscribe:
        if (unsubscribe == null) break;
        return unsubscribe(this as Unsubscribe);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Subscribe) subscribe,
      FutureOr<R> Function(Unsubscribe) unsubscribe,
      @required FutureOr<R> Function(PodcastAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _PodcastAction.Unsubscribe:
        if (unsubscribe == null) break;
        return unsubscribe(this as Unsubscribe);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Subscribe) subscribe,
      FutureOr<void> Function(Unsubscribe) unsubscribe}) {
    assert(() {
      if (subscribe == null && unsubscribe == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _PodcastAction.Unsubscribe:
        if (unsubscribe == null) break;
        return unsubscribe(this as Unsubscribe);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Subscribe extends PodcastAction {
  const Subscribe({@required this.podcast}) : super(_PodcastAction.Subscribe);

  final Podcast podcast;

  @override
  String toString() => 'Subscribe(podcast:${this.podcast})';
  @override
  List get props => [podcast];
}

@immutable
class Unsubscribe extends PodcastAction {
  const Unsubscribe({@required this.podcast})
      : super(_PodcastAction.Unsubscribe);

  final Podcast podcast;

  @override
  String toString() => 'Unsubscribe(podcast:${this.podcast})';
  @override
  List get props => [podcast];
}
