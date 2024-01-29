import 'package:flutter/material.dart';
import 'package:hangman_game/hangman.dart';

class PlaygorundController extends ChangeNotifier {
  var player = HangmanPlayer();

  void guessLetter(String letter) {
    player.guessLetter(letter);

    notifyListeners();
  }

  void refresh() {
    player = new HangmanPlayer();

    notifyListeners();
  }
}
