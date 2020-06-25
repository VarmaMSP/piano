// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'podcast_actions_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PodcastAction extends Equatable {
  const PodcastAction(this._type);

  factory PodcastAction.subscribed(
      {@required String podcastId,
      @required String podcastUrlParam,
      @required bool synced}) = Subscribed;

  factory PodcastAction.unsubscribed(
      {@required String podcastId,
      @required String podcastUrlParam,
      @required bool synced}) = Unsubscribed;

  final _PodcastAction _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Subscribed) subscribed,
      @required R Function(Unsubscribed) unsubscribed}) {
    assert(() {
      if (subscribed == null || unsubscribed == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribed:
        return subscribed(this as Subscribed);
      case _PodcastAction.Unsubscribed:
        return unsubscribed(this as Unsubscribed);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Subscribed) subscribed,
      @required FutureOr<R> Function(Unsubscribed) unsubscribed}) {
    assert(() {
      if (subscribed == null || unsubscribed == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribed:
        return subscribed(this as Subscribed);
      case _PodcastAction.Unsubscribed:
        return unsubscribed(this as Unsubscribed);
    }
  }

  R whenOrElse<R>(
      {R Function(Subscribed) subscribed,
      R Function(Unsubscribed) unsubscribed,
      @required R Function(PodcastAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _PodcastAction.Unsubscribed:
        if (unsubscribed == null) break;
        return unsubscribed(this as Unsubscribed);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Subscribed) subscribed,
      FutureOr<R> Function(Unsubscribed) unsubscribed,
      @required FutureOr<R> Function(PodcastAction) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _PodcastAction.Unsubscribed:
        if (unsubscribed == null) break;
        return unsubscribed(this as Unsubscribed);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Subscribed) subscribed,
      FutureOr<void> Function(Unsubscribed) unsubscribed}) {
    assert(() {
      if (subscribed == null && unsubscribed == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _PodcastAction.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _PodcastAction.Unsubscribed:
        if (unsubscribed == null) break;
        return unsubscribed(this as Unsubscribed);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Subscribed extends PodcastAction {
  const Subscribed(
      {@required this.podcastId,
      @required this.podcastUrlParam,
      @required this.synced})
      : super(_PodcastAction.Subscribed);

  final String podcastId;

  final String podcastUrlParam;

  final bool synced;

  @override
  String toString() =>
      'Subscribed(podcastId:${this.podcastId},podcastUrlParam:${this.podcastUrlParam},synced:${this.synced})';
  @override
  List get props => [podcastId, podcastUrlParam, synced];
}

@immutable
class Unsubscribed extends PodcastAction {
  const Unsubscribed(
      {@required this.podcastId,
      @required this.podcastUrlParam,
      @required this.synced})
      : super(_PodcastAction.Unsubscribed);

  final String podcastId;

  final String podcastUrlParam;

  final bool synced;

  @override
  String toString() =>
      'Unsubscribed(podcastId:${this.podcastId},podcastUrlParam:${this.podcastUrlParam},synced:${this.synced})';
  @override
  List get props => [podcastId, podcastUrlParam, synced];
}
