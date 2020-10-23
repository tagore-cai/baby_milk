import 'package:baby_milk/utils/local_storage.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  final String _storeKey = "";

  int _num = 0;

  List<String> list = [];

  get count => _num;

  void add() {
    _num++;
    notifyListeners();
  }

  void dec() {
    _num--;
    notifyListeners();
  }

  HomePageProvider() {
    _getRecordList();
  }

  Future<void> _getRecordList() async {
    list = await LocalStorage.getStringList(_storeKey) ?? [];
    notifyListeners();
  }

  insert(String item) {
    list.insert(0, item);
    if (list.length > 10) {
      list.removeLast();
    }
    notifyListeners();
    LocalStorage.setStringList(_storeKey, list);
  }
}
