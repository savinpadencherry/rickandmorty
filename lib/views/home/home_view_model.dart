import 'package:story/core/base/base_view_model.dart';
import 'package:story/core/repository/rickandmortyrepo.dart';

class HomeViewModel extends BaseViewModel {
  int _counter;

  HomeViewModel({int counter = 0}) : _counter = counter;

  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  void increment() => counter += 1;
}
