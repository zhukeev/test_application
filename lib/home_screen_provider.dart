import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

class HomeProvider extends ChangeNotifier {
  List<String> list = [];
  Timer _debounce;
  List<String> filteredTextList = [];

  HomeProvider() {
    rootBundle.loadString('assets/words.txt').then((value) {
      list = value.split('\n');
      filteredTextList = list;
      notifyListeners();
    });
  }

  bool get hasLoaded => list?.isNotEmpty ?? false;

  void searchText(String text) {
    if (text?.isEmpty ?? true && filteredTextList.length != list.length) {
      filteredTextList = list;
      notifyListeners();
    } else {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 50), () {
        filteredTextList = list
                ?.where((word) => word
                    .toLowerCase()
                    .startsWith(RegExp(text.trim(), caseSensitive: false)))
                ?.toList() ??
            [];
        notifyListeners();
      });
    }
  }
}
