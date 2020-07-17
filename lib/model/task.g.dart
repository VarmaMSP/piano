// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'task.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class TaskType extends Equatable {
  const TaskType(this._type);

  factory TaskType.cachePodcast({@required String urlParam}) = CachePodcast;

  factory TaskType.downloadEpisode(
      {@required String episodeId,
      @required String url,
      @required String filepath}) = DownloadEpisode;

  final _TaskType _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(CachePodcast) cachePodcast,
      @required R Function(DownloadEpisode) downloadEpisode}) {
    assert(() {
      if (cachePodcast == null || downloadEpisode == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskType.CachePodcast:
        return cachePodcast(this as CachePodcast);
      case _TaskType.DownloadEpisode:
        return downloadEpisode(this as DownloadEpisode);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(CachePodcast) cachePodcast,
      @required FutureOr<R> Function(DownloadEpisode) downloadEpisode}) {
    assert(() {
      if (cachePodcast == null || downloadEpisode == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskType.CachePodcast:
        return cachePodcast(this as CachePodcast);
      case _TaskType.DownloadEpisode:
        return downloadEpisode(this as DownloadEpisode);
    }
  }

  R whenOrElse<R>(
      {R Function(CachePodcast) cachePodcast,
      R Function(DownloadEpisode) downloadEpisode,
      @required R Function(TaskType) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskType.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
      case _TaskType.DownloadEpisode:
        if (downloadEpisode == null) break;
        return downloadEpisode(this as DownloadEpisode);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(CachePodcast) cachePodcast,
      FutureOr<R> Function(DownloadEpisode) downloadEpisode,
      @required FutureOr<R> Function(TaskType) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskType.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
      case _TaskType.DownloadEpisode:
        if (downloadEpisode == null) break;
        return downloadEpisode(this as DownloadEpisode);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(CachePodcast) cachePodcast,
      FutureOr<void> Function(DownloadEpisode) downloadEpisode}) {
    assert(() {
      if (cachePodcast == null && downloadEpisode == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _TaskType.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
      case _TaskType.DownloadEpisode:
        if (downloadEpisode == null) break;
        return downloadEpisode(this as DownloadEpisode);
    }
  }

  @override
  List get props => const [];
}

@immutable
class CachePodcast extends TaskType {
  const CachePodcast({@required this.urlParam}) : super(_TaskType.CachePodcast);

  final String urlParam;

  @override
  String toString() => 'CachePodcast(urlParam:${this.urlParam})';
  @override
  List get props => [urlParam];
}

@immutable
class DownloadEpisode extends TaskType {
  const DownloadEpisode(
      {@required this.episodeId, @required this.url, @required this.filepath})
      : super(_TaskType.DownloadEpisode);

  final String episodeId;

  final String url;

  final String filepath;

  @override
  String toString() =>
      'DownloadEpisode(episodeId:${this.episodeId},url:${this.url},filepath:${this.filepath})';
  @override
  List get props => [episodeId, url, filepath];
}
