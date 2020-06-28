// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'task.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Task extends Equatable {
  const Task(this._type);

  factory Task.cachePodcastToDb({@required String urlParam}) = CachePodcastToDb;

  final _Task _type;

//ignore: missing_return
  R when<R>({@required R Function(CachePodcastToDb) cachePodcastToDb}) {
    assert(() {
      if (cachePodcastToDb == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcastToDb:
        return cachePodcastToDb(this as CachePodcastToDb);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(CachePodcastToDb) cachePodcastToDb}) {
    assert(() {
      if (cachePodcastToDb == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcastToDb:
        return cachePodcastToDb(this as CachePodcastToDb);
    }
  }

  R whenOrElse<R>(
      {R Function(CachePodcastToDb) cachePodcastToDb,
      @required R Function(Task) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcastToDb:
        if (cachePodcastToDb == null) break;
        return cachePodcastToDb(this as CachePodcastToDb);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(CachePodcastToDb) cachePodcastToDb,
      @required FutureOr<R> Function(Task) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcastToDb:
        if (cachePodcastToDb == null) break;
        return cachePodcastToDb(this as CachePodcastToDb);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(CachePodcastToDb) cachePodcastToDb}) {
    assert(() {
      if (cachePodcastToDb == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Task.CachePodcastToDb:
        if (cachePodcastToDb == null) break;
        return cachePodcastToDb(this as CachePodcastToDb);
    }
  }

  @override
  List get props => const [];
}

@immutable
class CachePodcastToDb extends Task {
  const CachePodcastToDb({@required this.urlParam})
      : super(_Task.CachePodcastToDb);

  final String urlParam;

  @override
  String toString() => 'CachePodcastToDb(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}
