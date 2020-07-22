// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:when_expression/when_expression.dart';

/// StreamMap extends async StreamGroup to provide a
/// map like interface to add streams by key
class StreamMap<K, T> {
  final Set<K> _keys = {};
  final StreamGroup<Tuple2<K, T>> _streamGroup = StreamGroup<Tuple2<K, T>>();

  bool contains(K key) {
    return _keys.contains(key);
  }

  void add(K key, Stream<T> stream) {
    _keys.add(key);
    _streamGroup.add(stream.map((t) => Tuple2(key, t)));
  }

  Stream<Map<K, T>> get stream => _streamGroup.stream
      .scan<Map<K, T>>((acc, val, _) => {...acc, val.item1: val.item2}, {});

  Stream<List<T>> get streamValues => stream.map((val) => val.values.toList());
}

/// StreamDelayTill tries to delays stream till [delayDuration] is exhausted
/// or predicate returns true
class StreamDelayTill<T> {
  final Stream<T> inputStream;
  final Duration delayDuration;
  final bool Function(T) predicate;

  StreamDelayTill(
    this.inputStream,
    this.predicate, {
    this.delayDuration = const Duration(seconds: 2),
  });

  Stream<T> get stream {
    final t = delayDuration.inMilliseconds ~/ 100;

    return Rx.combineLatest2<int, T, Tuple2<int, T>>(
      Stream.periodic(Duration(milliseconds: 100), (x) => x).take(t),
      inputStream,
      (a, b) => Tuple2(a, b),
    ).where((e) => e.item1 == t || predicate(e.item2)).map((e) => e.item2);
  }
}

/// Creates a stream that waits [waitDuration] for a non null value
/// before closing
class StreamLongPoll<T> {
  final Stream<T> inputStream;
  final Duration waitDuration;
  final PublishSubject<T> _values = PublishSubject<T>();

  StreamSubscription<T> _inputStreamSubscription;

  StreamLongPoll(
    this.inputStream, {
    this.waitDuration = const Duration(minutes: 10),
  }) {
    /// 1. Let non null values pass else race the stream with wait duration.
    /// 2. Racing stream with duration in the above step can result in
    ///    same value being emitted the next time.
    /// 3. Close the stream on receiving a null value.
    _inputStreamSubscription = inputStream
        .asyncMap<T>(
          when<T, FutureOr<T>>({
            (t) => t != null: (t) => t,
            (t) => true: (_) => Rx.race([
                  inputStream.skip(1),
                  Stream.periodic(waitDuration, (_) => null).take(1),
                ]).first,
          }),
        )
        .distinct()
        .listen(
          when<T, void>({
            (t) => t != null: (t) {
              _values.add(t);
            },
            (t) => true: (_) {
              _values.close();
              _inputStreamSubscription?.cancel();
            },
          }),
        );
  }

  Stream<T> get stream => _values.stream;
}
