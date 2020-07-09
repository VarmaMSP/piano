import 'dart:async';

import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

/// StreamGroup extends async StreamGroup to provide a
/// map like interface to add streams to group by key
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

/// StreamDelayTill tries to delays stream till predicate returns true
/// and times out after duration of [delayDuration]
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
    )
        .where((e) => e.item1 < t - 1 ? predicate(e.item2) : true)
        .map((e) => e.item2);
  }
}
