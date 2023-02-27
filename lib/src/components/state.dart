import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_utilitty_tba/src/components/punchcarditem.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var selectedPunch = -1;
  var punchCards = <PunchCardItem>[];
  var punchDates = <Stopwatch>[];

  void setPunch(target) {
    print({target, punchDates});
    if (selectedPunch > -1) {
      punchDates[selectedPunch].stop();
    }
    if (target > -1) {
      punchDates[target].start();
    }
    selectedPunch = target;
    notifyListeners();
  }

  void updatePunchCards(List<PunchCardItem> x) {
    for (var i = punchDates.length; i < x.length; i++) {
      punchDates.add(Stopwatch());
    }
    punchCards = x;
  }

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
