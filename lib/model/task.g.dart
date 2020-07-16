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

  factory Task.downloadEpisode(
      {@required String episodeId,
      @required String url,
      @required String directory,
      @required String filename}) = DownloadEpisode;

  final _Task _type;

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
      case _Task.CachePodcast:
        return cachePodcast(this as CachePodcast);
      case _Task.DownloadEpisode:
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
      case _Task.CachePodcast:
        return cachePodcast(this as CachePodcast);
      case _Task.DownloadEpisode:
        return downloadEpisode(this as DownloadEpisode);
    }
  }

  R whenOrElse<R>(
      {R Function(CachePodcast) cachePodcast,
      R Function(DownloadEpisode) downloadEpisode,
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
      case _Task.DownloadEpisode:
        if (downloadEpisode == null) break;
        return downloadEpisode(this as DownloadEpisode);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(CachePodcast) cachePodcast,
      FutureOr<R> Function(DownloadEpisode) downloadEpisode,
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
      case _Task.DownloadEpisode:
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
      case _Task.CachePodcast:
        if (cachePodcast == null) break;
        return cachePodcast(this as CachePodcast);
      case _Task.DownloadEpisode:
        if (downloadEpisode == null) break;
        return downloadEpisode(this as DownloadEpisode);
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

@immutable
class DownloadEpisode extends Task {
  const DownloadEpisode(
      {@required this.episodeId,
      @required this.url,
      @required this.directory,
      @required this.filename})
      : super(_Task.DownloadEpisode);

  final String episodeId;

  final String url;

  final String directory;

  final String filename;

  @override
  String toString() =>
      'DownloadEpisode(episodeId:${this.episodeId},url:${this.url},directory:${this.directory},filename:${this.filename})';
  @override
  List get props => [episodeId, url, directory, filename];
}
