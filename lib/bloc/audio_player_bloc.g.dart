// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'audio_player_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SnapshotTransistion extends Equatable {
  const SnapshotTransistion(this._type);

  factory SnapshotTransistion.playAudioTrack(
      {@required AudioTrack audioTrack}) = PlayAudioTrack;

  factory SnapshotTransistion.addToQueueTop({@required AudioTrack audioTrack}) =
      AddToQueueTop;

  factory SnapshotTransistion.addToQueueBottom(
      {@required AudioTrack audioTrack}) = AddToQueueBottom;

  factory SnapshotTransistion.playPrevious() = PlayPrevious;

  factory SnapshotTransistion.playNext() = PlayNext;

  final _SnapshotTransistion _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(PlayAudioTrack) playAudioTrack,
      @required R Function(AddToQueueTop) addToQueueTop,
      @required R Function(AddToQueueBottom) addToQueueBottom,
      @required R Function(PlayPrevious) playPrevious,
      @required R Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          playPrevious == null ||
          playNext == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _SnapshotTransistion.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _SnapshotTransistion.PlayPrevious:
        return playPrevious(this as PlayPrevious);
      case _SnapshotTransistion.PlayNext:
        return playNext(this as PlayNext);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      @required FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      @required FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      @required FutureOr<R> Function(PlayPrevious) playPrevious,
      @required FutureOr<R> Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          playPrevious == null ||
          playNext == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _SnapshotTransistion.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _SnapshotTransistion.PlayPrevious:
        return playPrevious(this as PlayPrevious);
      case _SnapshotTransistion.PlayNext:
        return playNext(this as PlayNext);
    }
  }

  R whenOrElse<R>(
      {R Function(PlayAudioTrack) playAudioTrack,
      R Function(AddToQueueTop) addToQueueTop,
      R Function(AddToQueueBottom) addToQueueBottom,
      R Function(PlayPrevious) playPrevious,
      R Function(PlayNext) playNext,
      @required R Function(SnapshotTransistion) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _SnapshotTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _SnapshotTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _SnapshotTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      FutureOr<R> Function(PlayPrevious) playPrevious,
      FutureOr<R> Function(PlayNext) playNext,
      @required FutureOr<R> Function(SnapshotTransistion) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _SnapshotTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _SnapshotTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _SnapshotTransistion.PlayNext:
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
      FutureOr<void> Function(PlayPrevious) playPrevious,
      FutureOr<void> Function(PlayNext) playNext}) {
    assert(() {
      if (playAudioTrack == null &&
          addToQueueTop == null &&
          addToQueueBottom == null &&
          playPrevious == null &&
          playNext == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _SnapshotTransistion.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _SnapshotTransistion.PlayPrevious:
        if (playPrevious == null) break;
        return playPrevious(this as PlayPrevious);
      case _SnapshotTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
    }
  }

  @override
  List get props => const [];
}

@immutable
class PlayAudioTrack extends SnapshotTransistion {
  const PlayAudioTrack({@required this.audioTrack})
      : super(_SnapshotTransistion.PlayAudioTrack);

  final AudioTrack audioTrack;

  @override
  String toString() => 'PlayAudioTrack(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueTop extends SnapshotTransistion {
  const AddToQueueTop({@required this.audioTrack})
      : super(_SnapshotTransistion.AddToQueueTop);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueTop(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueBottom extends SnapshotTransistion {
  const AddToQueueBottom({@required this.audioTrack})
      : super(_SnapshotTransistion.AddToQueueBottom);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueBottom(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class PlayPrevious extends SnapshotTransistion {
  const PlayPrevious._() : super(_SnapshotTransistion.PlayPrevious);

  factory PlayPrevious() {
    _instance ??= const PlayPrevious._();
    return _instance;
  }

  static PlayPrevious _instance;
}

@immutable
class PlayNext extends SnapshotTransistion {
  const PlayNext._() : super(_SnapshotTransistion.PlayNext);

  factory PlayNext() {
    _instance ??= const PlayNext._();
    return _instance;
  }

  static PlayNext _instance;
}
