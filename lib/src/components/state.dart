import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite(propTarget) {
    var target = propTarget;
    target ??= current;

    if (favorites.contains(target)) {
      favorites.remove(target);
    } else {
      favorites.add(target);
    }
    notifyListeners();
  }
}
