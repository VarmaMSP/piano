// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'app_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent(this._type);

  factory AppEvent.subscribe(
      {@required Podcast podcast, @required bool synced}) = Subscribe;

  factory AppEvent.unsubscribe(
      {@required Podcast podcast, @required bool synced}) = Unsubscribe;

  final _AppEvent _type;

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
      case _AppEvent.Subscribe:
        return subscribe(this as Subscribe);
      case _AppEvent.Unsubscribe:
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
      case _AppEvent.Subscribe:
        return subscribe(this as Subscribe);
      case _AppEvent.Unsubscribe:
        return unsubscribe(this as Unsubscribe);
    }
  }

  R whenOrElse<R>(
      {R Function(Subscribe) subscribe,
      R Function(Unsubscribe) unsubscribe,
      @required R Function(AppEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AppEvent.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _AppEvent.Unsubscribe:
        if (unsubscribe == null) break;
        return unsubscribe(this as Unsubscribe);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Subscribe) subscribe,
      FutureOr<R> Function(Unsubscribe) unsubscribe,
      @required FutureOr<R> Function(AppEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _AppEvent.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _AppEvent.Unsubscribe:
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
      case _AppEvent.Subscribe:
        if (subscribe == null) break;
        return subscribe(this as Subscribe);
      case _AppEvent.Unsubscribe:
        if (unsubscribe == null) break;
        return unsubscribe(this as Unsubscribe);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Subscribe extends AppEvent {
  const Subscribe({@required this.podcast, @required this.synced})
      : super(_AppEvent.Subscribe);

  final Podcast podcast;

  final bool synced;

  @override
  String toString() =>
      'Subscribe(podcast:${this.podcast},synced:${this.synced})';
  @override
  List get props => [podcast, synced];
}

@immutable
class Unsubscribe extends AppEvent {
  const Unsubscribe({@required this.podcast, @required this.synced})
      : super(_AppEvent.Unsubscribe);

  final Podcast podcast;

  final bool synced;

  @override
  String toString() =>
      'Unsubscribe(podcast:${this.podcast},synced:${this.synced})';
  @override
  List get props => [podcast, synced];
}
