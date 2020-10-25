import 'dart:convert';
import 'package:baby_milk/model/faces_model.dart';
import 'package:intl/intl.dart';

import 'package:baby_milk/utils/local_storage.dart';
import 'package:flutter/material.dart';

final DateFormat dateFormat = new DateFormat.yMd();

class FFecesPageProvider with ChangeNotifier {
  final String _storeKey = "__feces_store";
  Map<String, List<FacesModel>> fecesCounts = {};

  FFecesPageProvider() {
    _getRecordList();
  }

  Future<void> _getRecordList() async {
    String _fecesCounts = await LocalStorage.getString(_storeKey) ?? {};
    fecesCounts = json.decode(_fecesCounts);
    notifyListeners();
  }

  get keys => fecesCounts.keys;

  void inc() {
    DateTime now = DateTime.now();
    String key = dateFormat.format(now);
    // fecesCounts[key] = fecesCounts[key] ?? ;
    // fecesCounts[key] += 1;
    notifyListeners();
    LocalStorage.setString(_storeKey, json.encode(fecesCounts));
  }

  void remove(String key) {
    fecesCounts.remove(key);
    notifyListeners();
    LocalStorage.setString(_storeKey, json.encode(fecesCounts));
  }
}
