// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'show_snack_bar_bloc.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Notification extends Equatable {
  const Notification(this._type);

  factory Notification.subscribed() = Subscribed;

  factory Notification.unsubscribed() = Unsubscribed;

  final _Notification _type;

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
      case _Notification.Subscribed:
        return subscribed(this as Subscribed);
      case _Notification.Unsubscribed:
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
      case _Notification.Subscribed:
        return subscribed(this as Subscribed);
      case _Notification.Unsubscribed:
        return unsubscribed(this as Unsubscribed);
    }
  }

  R whenOrElse<R>(
      {R Function(Subscribed) subscribed,
      R Function(Unsubscribed) unsubscribed,
      @required R Function(Notification) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Notification.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _Notification.Unsubscribed:
        if (unsubscribed == null) break;
        return unsubscribed(this as Unsubscribed);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Subscribed) subscribed,
      FutureOr<R> Function(Unsubscribed) unsubscribed,
      @required FutureOr<R> Function(Notification) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Notification.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _Notification.Unsubscribed:
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
      case _Notification.Subscribed:
        if (subscribed == null) break;
        return subscribed(this as Subscribed);
      case _Notification.Unsubscribed:
        if (unsubscribed == null) break;
        return unsubscribed(this as Unsubscribed);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Subscribed extends Notification {
  const Subscribed._() : super(_Notification.Subscribed);

  factory Subscribed() {
    _instance ??= const Subscribed._();
    return _instance;
  }

  static Subscribed _instance;
}

@immutable
class Unsubscribed extends Notification {
  const Unsubscribed._() : super(_Notification.Unsubscribed);

  factory Unsubscribed() {
    _instance ??= const Unsubscribed._();
    return _instance;
  }

  static Unsubscribed _instance;
}
