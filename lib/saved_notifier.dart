import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedNotifier extends ChangeNotifier {
  final Set<WordPair> _saved = <WordPair>{};

  void toggleSaved(WordPair newSavaed) {
    final alreadySaved = _saved.contains(newSavaed);

    if (alreadySaved) {
      _saved.remove(newSavaed);
    } else {
      _saved.add(newSavaed);
    }

    notifyListeners(); // 데이터 변경됬다 다 알아서 변경해라
  }

  bool alreadyContain(WordPair wordPair) {
    return _saved.contains(wordPair);
  }

  Set<WordPair> get saved => _saved;
  // Set<WordPair> getSaved(){
  //   return _saved;
  // }
  // 와 같은 것
  // 질문해야지
}
