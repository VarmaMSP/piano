// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'task.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class TaskFunction extends Equatable {
  const TaskFunction(this._type);

  factory TaskFunction.savePodcastToDb({@required String urlParam}) =
      SavePodcastToDb;

  factory TaskFunction.invalid() = Invalid;

  final _TaskFunction _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(SavePodcastToDb) savePodcastToDb,
      @required R Function(Invalid) invalid}) {
    assert(() {
      if (savePodcastToDb == null || invalid == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskFunction.SavePodcastToDb:
        return savePodcastToDb(this as SavePodcastToDb);
      case _TaskFunction.Invalid:
        return invalid(this as Invalid);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(SavePodcastToDb) savePodcastToDb,
      @required FutureOr<R> Function(Invalid) invalid}) {
    assert(() {
      if (savePodcastToDb == null || invalid == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskFunction.SavePodcastToDb:
        return savePodcastToDb(this as SavePodcastToDb);
      case _TaskFunction.Invalid:
        return invalid(this as Invalid);
    }
  }

  R whenOrElse<R>(
      {R Function(SavePodcastToDb) savePodcastToDb,
      R Function(Invalid) invalid,
      @required R Function(TaskFunction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskFunction.SavePodcastToDb:
        if (savePodcastToDb == null) break;
        return savePodcastToDb(this as SavePodcastToDb);
      case _TaskFunction.Invalid:
        if (invalid == null) break;
        return invalid(this as Invalid);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(SavePodcastToDb) savePodcastToDb,
      FutureOr<R> Function(Invalid) invalid,
      @required FutureOr<R> Function(TaskFunction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskFunction.SavePodcastToDb:
        if (savePodcastToDb == null) break;
        return savePodcastToDb(this as SavePodcastToDb);
      case _TaskFunction.Invalid:
        if (invalid == null) break;
        return invalid(this as Invalid);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(SavePodcastToDb) savePodcastToDb,
      FutureOr<void> Function(Invalid) invalid}) {
    assert(() {
      if (savePodcastToDb == null && invalid == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskFunction.SavePodcastToDb:
        if (savePodcastToDb == null) break;
        return savePodcastToDb(this as SavePodcastToDb);
      case _TaskFunction.Invalid:
        if (invalid == null) break;
        return invalid(this as Invalid);
    }
  }

  @override
  List get props => const [];
}

@immutable
class SavePodcastToDb extends TaskFunction {
  const SavePodcastToDb({@required this.urlParam})
      : super(_TaskFunction.SavePodcastToDb);

  final String urlParam;

  @override
  String toString() => 'SavePodcastToDb(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}

@immutable
class Invalid extends TaskFunction {
  const Invalid._() : super(_TaskFunction.Invalid);

  factory Invalid() {
    _instance ??= const Invalid._();
    return _instance;
  }

  static Invalid _instance;
}
