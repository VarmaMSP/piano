// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'audio_player_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class QueueTransistion extends Equatable {
  const QueueTransistion(this._type);

  factory QueueTransistion.playAudioTrack({@required AudioTrack audioTrack}) =
      PlayAudioTrack;

  factory QueueTransistion.addToQueueTop({@required AudioTrack audioTrack}) =
      AddToQueueTop;

  factory QueueTransistion.addToQueueBottom({@required AudioTrack audioTrack}) =
      AddToQueueBottom;

  factory QueueTransistion.changeTrackPosition(
      {@required int from, @required int to}) = ChangeTrackPosition;

  factory QueueTransistion.playPrevious() = PlayPrevious;

  factory QueueTransistion.playNext() = PlayNext;

  final _QueueTransistion _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(PlayAudioTrack) playAudioTrack,
      @required R Function(AddToQueueTop) addToQueueTop,
      @required R Function(AddToQueueBottom) addToQueueBottom,
      @required R Function(ChangeTrackPosition) changeTrackPosition,
      @required R Function(PlayPrevious) playPrevious,
      @required R Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          changeTrackPosition == null ||
          playPrevious == null ||
          playNext == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _QueueTransistion.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransistion.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransistion.ChangeTrackPosition:
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransistion.PlayPrevious:
        return playPrevious(this as PlayPrevious);
      case _QueueTransistion.PlayNext:
        return playNext(this as PlayNext);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      @required FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      @required FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      @required FutureOr<R> Function(ChangeTrackPosition) changeTrackPosition,
      @required FutureOr<R> Function(PlayPrevious) playPrevious,
      @required FutureOr<R> Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          changeTrackPosition == null ||
          playPrevious == null ||
          playNext == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _QueueTransistion.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransistion.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransistion.ChangeTrackPosition:
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransistion.PlayPrevious:
        return playPrevious(this as PlayPrevious);
      case _QueueTransistion.PlayNext:
        return playNext(this as PlayNext);
    }
  }

  R whenOrElse<R>(
      {R Function(PlayAudioTrack) playAudioTrack,
      R Function(AddToQueueTop) addToQueueTop,
      R Function(AddToQueueBottom) addToQueueBottom,
      R Function(ChangeTrackPosition) changeTrackPosition,
      R Function(PlayPrevious) playPrevious,
      R Function(PlayNext) playNext,
      @required R Function(QueueTransistion) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _QueueTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransistion.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _QueueTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      FutureOr<R> Function(ChangeTrackPosition) changeTrackPosition,
      FutureOr<R> Function(PlayPrevious) playPrevious,
      FutureOr<R> Function(PlayNext) playNext,
      @required FutureOr<R> Function(QueueTransistion) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _QueueTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransistion.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _QueueTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(PlayAudioTrack) playAudioTrack,
      FutureOr<void> Function(AddToQueueTop) addToQueueTop,
      FutureOr<void> Function(AddToQueueBottom) addToQueueBottom,
      FutureOr<void> Function(ChangeTrackPosition) changeTrackPosition,
      FutureOr<void> Function(PlayPrevious) playPrevious,
      FutureOr<void> Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null &&
          addToQueueTop == null &&
          addToQueueBottom == null &&
          changeTrackPosition == null &&
          playPrevious == null &&
          playNext == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _QueueTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransistion.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _QueueTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
    }
  }

  @override
  List get props => const [];
}

@immutable
class PlayAudioTrack extends QueueTransistion {
  const PlayAudioTrack({@required this.audioTrack})
      : super(_QueueTransistion.PlayAudioTrack);

  final AudioTrack audioTrack;

  @override
  String toString() => 'PlayAudioTrack(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueTop extends QueueTransistion {
  const AddToQueueTop({@required this.audioTrack})
      : super(_QueueTransistion.AddToQueueTop);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueTop(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueBottom extends QueueTransistion {
  const AddToQueueBottom({@required this.audioTrack})
      : super(_QueueTransistion.AddToQueueBottom);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueBottom(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class ChangeTrackPosition extends QueueTransistion {
  const ChangeTrackPosition({@required this.from, @required this.to})
      : super(_QueueTransistion.ChangeTrackPosition);

  final int from;

  final int to;

  @override
  String toString() => 'ChangeTrackPosition(from:${this.from},to:${this.to})';
  @override
  List get props => [from, to];
}

@immutable
class PlayPrevious extends QueueTransistion {
  const PlayPrevious._() : super(_QueueTransistion.PlayPrevious);

  factory PlayPrevious() {
    _instance ??= const PlayPrevious._();
    return _instance;
  }

  static PlayPrevious _instance;
}

@immutable
class PlayNext extends QueueTransistion {
  const PlayNext._() : super(_QueueTransistion.PlayNext);

  factory PlayNext() {
    _instance ??= const PlayNext._();
    return _instance;
  }

  static PlayNext _instance;
}
