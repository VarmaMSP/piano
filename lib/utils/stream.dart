import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class _Page<T> {
  final int offset;
  final List<T> items;

  _Page({this.offset, this.items});
}

class PaginationStream<T> {
  final Set<int> _offsets = {};
  final StreamGroup<_Page<T>> _pageStreamGroup = StreamGroup<_Page<T>>();

  bool containsPage(int offset) {
    return _offsets.contains(offset);
  }

  void addStream(int offset, Stream<List<T>> stream) {
    _offsets.add(offset);

    /// For first page wait till stream returns a non empty list
    if (offset == 0) {
      _pageStreamGroup.add(
        stream
            .where((e) => e.isNotEmpty)
            .map((e) => _Page<T>(offset: 0, items: e))
            .distinct(),
      );
      return;
    }

    /// For subsequent pages sample stream every 250 milliseconds 8 times
    /// and filter any nonEmpty lists. Allow all strems results after the 8 sample
    _pageStreamGroup.add(
      Rx.combineLatest2<int, List<T>, Tuple2<int, List<T>>>(
        Stream.periodic(Duration(milliseconds: 250), (x) => x).take(9),
        stream,
        (a, b) => Tuple2(a, b),
      )
          .where((e) => e.item1 < 8 ? e.item2.isNotEmpty : true)
          .map((e) => _Page<T>(offset: offset, items: e.item2))
          .distinct(),
    );
  }

  Stream<List<List<T>>> get stream =>
      _pageStreamGroup.stream.scan<Map<int, List<T>>>(
        (acc, val, _) => {...acc, val.offset: val.items},
        {},
      ).map((e) => e.values.toList());
}
