// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'audio_player_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class QueueTransition extends Equatable {
  const QueueTransition(this._type);

  factory QueueTransition.play({@required AudioTrack audioTrack}) = Play;

  factory QueueTransition.addToQueueTop({@required AudioTrack audioTrack}) =
      AddToQueueTop;

  factory QueueTransition.addToQueueBottom({@required AudioTrack audioTrack}) =
      AddToQueueBottom;

  factory QueueTransition.changeTrackPosition(
      {@required int from, @required int to}) = ChangeTrackPosition;

  factory QueueTransition.playTrack({@required int position}) = PlayTrack;

  factory QueueTransition.removeTrack({@required int position}) = RemoveTrack;

  factory QueueTransition.clearQueue({@required bool askUser}) = ClearQueue;

  final _QueueTransition _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Play) play,
      @required R Function(AddToQueueTop) addToQueueTop,
      @required R Function(AddToQueueBottom) addToQueueBottom,
      @required R Function(ChangeTrackPosition) changeTrackPosition,
      @required R Function(PlayTrack) playTrack,
      @required R Function(RemoveTrack) removeTrack,
      @required R Function(ClearQueue) clearQueue}) {
    assert(() {
      if (play == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          changeTrackPosition == null ||
          playTrack == null ||
          removeTrack == null ||
          clearQueue == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransition.Play:
        return play(this as Play);
      case _QueueTransition.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransition.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransition.ChangeTrackPosition:
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransition.PlayTrack:
        return playTrack(this as PlayTrack);
      case _QueueTransition.RemoveTrack:
        return removeTrack(this as RemoveTrack);
      case _QueueTransition.ClearQueue:
        return clearQueue(this as ClearQueue);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Play) play,
      @required FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      @required FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      @required FutureOr<R> Function(ChangeTrackPosition) changeTrackPosition,
      @required FutureOr<R> Function(PlayTrack) playTrack,
      @required FutureOr<R> Function(RemoveTrack) removeTrack,
      @required FutureOr<R> Function(ClearQueue) clearQueue}) {
    assert(() {
      if (play == null ||
          addToQueueTop == null ||
          addToQueueBottom == null ||
          changeTrackPosition == null ||
          playTrack == null ||
          removeTrack == null ||
          clearQueue == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransition.Play:
        return play(this as Play);
      case _QueueTransition.AddToQueueTop:
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransition.AddToQueueBottom:
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransition.ChangeTrackPosition:
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransition.PlayTrack:
        return playTrack(this as PlayTrack);
      case _QueueTransition.RemoveTrack:
        return removeTrack(this as RemoveTrack);
      case _QueueTransition.ClearQueue:
        return clearQueue(this as ClearQueue);
    }
  }

  R whenOrElse<R>(
      {R Function(Play) play,
      R Function(AddToQueueTop) addToQueueTop,
      R Function(AddToQueueBottom) addToQueueBottom,
      R Function(ChangeTrackPosition) changeTrackPosition,
      R Function(PlayTrack) playTrack,
      R Function(RemoveTrack) removeTrack,
      R Function(ClearQueue) clearQueue,
      @required R Function(QueueTransition) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransition.Play:
        if (play == null) break;
        return play(this as Play);
      case _QueueTransition.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransition.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransition.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransition.PlayTrack:
        if (playTrack == null) break;
        return playTrack(this as PlayTrack);
      case _QueueTransition.RemoveTrack:
        if (removeTrack == null) break;
        return removeTrack(this as RemoveTrack);
      case _QueueTransition.ClearQueue:
        if (clearQueue == null) break;
        return clearQueue(this as ClearQueue);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Play) play,
      FutureOr<R> Function(AddToQueueTop) addToQueueTop,
      FutureOr<R> Function(AddToQueueBottom) addToQueueBottom,
      FutureOr<R> Function(ChangeTrackPosition) changeTrackPosition,
      FutureOr<R> Function(PlayTrack) playTrack,
      FutureOr<R> Function(RemoveTrack) removeTrack,
      FutureOr<R> Function(ClearQueue) clearQueue,
      @required FutureOr<R> Function(QueueTransition) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransition.Play:
        if (play == null) break;
        return play(this as Play);
      case _QueueTransition.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransition.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransition.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransition.PlayTrack:
        if (playTrack == null) break;
        return playTrack(this as PlayTrack);
      case _QueueTransition.RemoveTrack:
        if (removeTrack == null) break;
        return removeTrack(this as RemoveTrack);
      case _QueueTransition.ClearQueue:
        if (clearQueue == null) break;
        return clearQueue(this as ClearQueue);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Play) play,
      FutureOr<void> Function(AddToQueueTop) addToQueueTop,
      FutureOr<void> Function(AddToQueueBottom) addToQueueBottom,
      FutureOr<void> Function(ChangeTrackPosition) changeTrackPosition,
      FutureOr<void> Function(PlayTrack) playTrack,
      FutureOr<void> Function(RemoveTrack) removeTrack,
      FutureOr<void> Function(ClearQueue) clearQueue}) {
    assert(() {
      if (play == null &&
          addToQueueTop == null &&
          addToQueueBottom == null &&
          changeTrackPosition == null &&
          playTrack == null &&
          removeTrack == null &&
          clearQueue == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _QueueTransition.Play:
        if (play == null) break;
        return play(this as Play);
      case _QueueTransition.AddToQueueTop:
        if (addToQueueTop == null) break;
        return addToQueueTop(this as AddToQueueTop);
      case _QueueTransition.AddToQueueBottom:
        if (addToQueueBottom == null) break;
        return addToQueueBottom(this as AddToQueueBottom);
      case _QueueTransition.ChangeTrackPosition:
        if (changeTrackPosition == null) break;
        return changeTrackPosition(this as ChangeTrackPosition);
      case _QueueTransition.PlayTrack:
        if (playTrack == null) break;
        return playTrack(this as PlayTrack);
      case _QueueTransition.RemoveTrack:
        if (removeTrack == null) break;
        return removeTrack(this as RemoveTrack);
      case _QueueTransition.ClearQueue:
        if (clearQueue == null) break;
        return clearQueue(this as ClearQueue);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Play extends QueueTransition {
  const Play({@required this.audioTrack}) : super(_QueueTransition.Play);

  final AudioTrack audioTrack;

  @override
  String toString() => 'Play(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueTop extends QueueTransition {
  const AddToQueueTop({@required this.audioTrack})
      : super(_QueueTransition.AddToQueueTop);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueTop(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class AddToQueueBottom extends QueueTransition {
  const AddToQueueBottom({@required this.audioTrack})
      : super(_QueueTransition.AddToQueueBottom);

  final AudioTrack audioTrack;

  @override
  String toString() => 'AddToQueueBottom(audioTrack:${this.audioTrack})';
  @override
  List get props => [audioTrack];
}

@immutable
class ChangeTrackPosition extends QueueTransition {
  const ChangeTrackPosition({@required this.from, @required this.to})
      : super(_QueueTransition.ChangeTrackPosition);

  final int from;

  final int to;

  @override
  String toString() => 'ChangeTrackPosition(from:${this.from},to:${this.to})';
  @override
  List get props => [from, to];
}

@immutable
class PlayTrack extends QueueTransition {
  const PlayTrack({@required this.position})
      : super(_QueueTransition.PlayTrack);

  final int position;

  @override
  String toString() => 'PlayTrack(position:${this.position})';
  @override
  List get props => [position];
}

@immutable
class RemoveTrack extends QueueTransition {
  const RemoveTrack({@required this.position})
      : super(_QueueTransition.RemoveTrack);

  final int position;

  @override
  String toString() => 'RemoveTrack(position:${this.position})';
  @override
  List get props => [position];
}

@immutable
class ClearQueue extends QueueTransition {
  const ClearQueue({@required this.askUser})
      : super(_QueueTransition.ClearQueue);

  final bool askUser;

  @override
  String toString() => 'ClearQueue(askUser:${this.askUser})';
  @override
  List get props => [askUser];
}
