// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, cast_to_non_type, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'audio_player_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class SnapshotTransistion extends Equatable {
  const SnapshotTransistion(this._type);

  factory SnapshotTransistion.playAudioTrack(
      {@required AudioTrack audioTrack}) = PlayAudioTrack;

  factory SnapshotTransistion.playNext() = PlayNext;

  factory SnapshotTransistion.addToQueue() = AddToQueue;

  final _SnapshotTransistion _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(PlayAudioTrack) playAudioTrack,
      @required R Function(PlayNext) playNext,
      @required R Function(AddToQueue) addToQueue}) {
    assert(() {
      if (playAudioTrack == null || playNext == null || addToQueue == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.PlayNext:
        return playNext(this as PlayNext);
      case _SnapshotTransistion.AddToQueue:
        return addToQueue(this as AddToQueue);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      @required FutureOr<R> Function(PlayNext) playNext,
      @required FutureOr<R> Function(AddToQueue) addToQueue}) {
    assert(() {
      if (playAudioTrack == null || playNext == null || addToQueue == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.PlayNext:
        return playNext(this as PlayNext);
      case _SnapshotTransistion.AddToQueue:
        return addToQueue(this as AddToQueue);
    }
  }

  R whenOrElse<R>(
      {R Function(PlayAudioTrack) playAudioTrack,
      R Function(PlayNext) playNext,
      R Function(AddToQueue) addToQueue,
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
      case _SnapshotTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
      case _SnapshotTransistion.AddToQueue:
        if (addToQueue == null) break;
        return addToQueue(this as AddToQueue);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(PlayAudioTrack) playAudioTrack,
      FutureOr<R> Function(PlayNext) playNext,
      FutureOr<R> Function(AddToQueue) addToQueue,
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
      case _SnapshotTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
      case _SnapshotTransistion.AddToQueue:
        if (addToQueue == null) break;
        return addToQueue(this as AddToQueue);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(PlayAudioTrack) playAudioTrack,
      FutureOr<void> Function(PlayNext) playNext,
      FutureOr<void> Function(AddToQueue) addToQueue}) {
    assert(() {
      if (playAudioTrack == null && playNext == null && addToQueue == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _SnapshotTransistion.PlayAudioTrack:
        if (playAudioTrack == null) break;
        return playAudioTrack(this as PlayAudioTrack);
      case _SnapshotTransistion.PlayNext:
        if (playNext == null) break;
        return playNext(this as PlayNext);
      case _SnapshotTransistion.AddToQueue:
        if (addToQueue == null) break;
        return addToQueue(this as AddToQueue);
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
class PlayNext extends SnapshotTransistion {
  const PlayNext._() : super(_SnapshotTransistion.PlayNext);

  factory PlayNext() {
    _instance ??= const PlayNext._();
    return _instance;
  }

  static PlayNext _instance;
}

@immutable
class AddToQueue extends SnapshotTransistion {
  const AddToQueue._() : super(_SnapshotTransistion.AddToQueue);

  factory AddToQueue() {
    _instance ??= const AddToQueue._();
    return _instance;
  }

  static AddToQueue _instance;
}
