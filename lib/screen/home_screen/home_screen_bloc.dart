import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  /// Stream of curations
  final BehaviorSubject<List<Curation>> _curations =
      BehaviorSubject<List<Curation>>();

  /// Stream of categories
  final BehaviorSubject<List<Category>> _categories =
      BehaviorSubject<List<Category>>();

  HomeScreenBloc() {
    _loadPage();
  }

  Future<void> _loadPage() async {
    final response = await makeRequest(method: 'GET', path: '/');
    _curations.add(response.curations);
    _categories.add(response.primaryCategories);
  }

  /// curations stream
  Stream<List<Curation>> get curations => _curations.stream;

  /// categories stream
  Stream<List<Category>> get categories => _categories.stream;

  Future<void> dispose() async {
    await _curations.close();
    await _categories.close();
  }
}
