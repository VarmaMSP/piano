// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'episode_actions_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class EpisodeAction extends Equatable {
  const EpisodeAction(this._type);

  factory EpisodeAction.startDownload(
      {@required Episode episode, @required Podcast podcast}) = StartDownload;

  factory EpisodeAction.cancelDownload({@required String episodeId}) =
      CancelDownload;

  final _EpisodeAction _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(StartDownload) startDownload,
      @required R Function(CancelDownload) cancelDownload}) {
    assert(() {
      if (startDownload == null || cancelDownload == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _EpisodeAction.StartDownload:
        return startDownload(this as StartDownload);
      case _EpisodeAction.CancelDownload:
        return cancelDownload(this as CancelDownload);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(StartDownload) startDownload,
      @required FutureOr<R> Function(CancelDownload) cancelDownload}) {
    assert(() {
      if (startDownload == null || cancelDownload == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _EpisodeAction.StartDownload:
        return startDownload(this as StartDownload);
      case _EpisodeAction.CancelDownload:
        return cancelDownload(this as CancelDownload);
    }
  }

  R whenOrElse<R>(
      {R Function(StartDownload) startDownload,
      R Function(CancelDownload) cancelDownload,
      @required R Function(EpisodeAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _EpisodeAction.StartDownload:
        if (startDownload == null) break;
        return startDownload(this as StartDownload);
      case _EpisodeAction.CancelDownload:
        if (cancelDownload == null) break;
        return cancelDownload(this as CancelDownload);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(StartDownload) startDownload,
      FutureOr<R> Function(CancelDownload) cancelDownload,
      @required FutureOr<R> Function(EpisodeAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _EpisodeAction.StartDownload:
        if (startDownload == null) break;
        return startDownload(this as StartDownload);
      case _EpisodeAction.CancelDownload:
        if (cancelDownload == null) break;
        return cancelDownload(this as CancelDownload);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(StartDownload) startDownload,
      FutureOr<void> Function(CancelDownload) cancelDownload}) {
    assert(() {
      if (startDownload == null && cancelDownload == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _EpisodeAction.StartDownload:
        if (startDownload == null) break;
        return startDownload(this as StartDownload);
      case _EpisodeAction.CancelDownload:
        if (cancelDownload == null) break;
        return cancelDownload(this as CancelDownload);
    }
  }

  @override
  List get props => const [];
}

@immutable
class StartDownload extends EpisodeAction {
  const StartDownload({@required this.episode, @required this.podcast})
      : super(_EpisodeAction.StartDownload);

  final Episode episode;

  final Podcast podcast;

  @override
  String toString() =>
      'StartDownload(episode:${this.episode},podcast:${this.podcast})';
  @override
  List get props => [episode, podcast];
}

@immutable
class CancelDownload extends EpisodeAction {
  const CancelDownload({@required this.episodeId})
      : super(_EpisodeAction.CancelDownload);

  final String episodeId;

  @override
  String toString() => 'CancelDownload(episodeId:${this.episodeId})';
  @override
  List get props => [episodeId];
}
