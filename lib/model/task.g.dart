// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'task.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Task extends Equatable {
  const Task(this._type);

  factory Task.cachePodcast({@required String urlParam}) = CachePodcast;

  final _Task _type;

//ignore: missing_return
  R when<R>({@required R Function(CachePodcast) cachePodcast}) {
    assert(() {
      if (cachePodcast == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcast:
        return cachePodcast(this as CachePodcast);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(CachePodcast) cachePodcast}) {
    assert(() {
      if (cachePodcast == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcast:
        return cachePodcast(this as CachePodcast);
    }
  }

  R whenOrElse<R>(
      {R Function(CachePodcast) cachePodcast,
      @required R Function(Task) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(CachePodcast) cachePodcast,
      @required FutureOr<R> Function(Task) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(CachePodcast) cachePodcast}) {
    assert(() {
      if (cachePodcast == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
    }
  }

  @override
  List get props => const [];
}

@immutable
class CachePodcast extends Task {
  const CachePodcast({@required this.urlParam}) : super(_Task.CachePodcast);

  final String urlParam;

  @override
  String toString() => 'CachePodcast(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}
