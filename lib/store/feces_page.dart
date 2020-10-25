import 'package:baby_milk/utils/local_storage.dart';
import 'package:flutter/material.dart';

class FacesPageProvider with ChangeNotifier {
  final String _storeKey = "__feces_store0";

  List<String> list = [];

  FacesPageProvider() {
    _getRecordList();
  }

  get hadVal => list.length > 0;

  Future<void> _getRecordList() async {
    list = await LocalStorage.getStringList(_storeKey) ?? [];
    notifyListeners();
  }

  void insert(String item) {
    list.insert(0, item);
    notifyListeners();
    LocalStorage.setStringList(_storeKey, list);
  }

  void remove(String item){
    list.remove(item);
    notifyListeners();
    LocalStorage.setStringList(_storeKey, list);
  }
}
