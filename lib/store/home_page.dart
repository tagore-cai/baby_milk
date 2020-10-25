import 'package:baby_milk/utils/local_storage.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  final String _storeKey = "";

  List<String> list = [];

  HomePageProvider() {
    _getRecordList();
  }

  Future<void> _getRecordList() async {
    list = await LocalStorage.getStringList(_storeKey) ?? [];
    notifyListeners();
  }

  void insert(String item) {
    list.insert(0, item);
    // if (list.length > 10) {
    //   list.removeLast();
    // }
    notifyListeners();
    LocalStorage.setStringList(_storeKey, list);
  }

  void remove(String item){
    list.remove(item);
    notifyListeners();
    LocalStorage.setStringList(_storeKey, list);
  }
}
