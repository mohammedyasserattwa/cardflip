import 'dart:collection';

import 'package:flutter/material.dart';

class FlashcardModel {
  final List<String> _terms = [
    "Math",
    "Physics",
    "Biology",
    "Chemistry",
    "Computer Science",
    "Machine Learning"
  ];
  final List<String> _definitions = [
    "Math Definition",
    "Physics definition",
    "Biology Definition",
    "Chemistry Definition",
    "Computer Science",
    "Machine Learning"
  ];
  final List<String> _cardBackgrounds = [
    "Images/cards/flashcards/2.png",
    "Images/cards/flashcards/1.png",
    "Images/cards/flashcards/0.png",
  ];
  int queue = 0;
  FlashcardModel() {
    queue = 1;
  }

  List<String> get getTerms => _terms;
  List<String> get getDefinitions => _definitions;

  List<String> get getImages => _cardBackgrounds;
}
