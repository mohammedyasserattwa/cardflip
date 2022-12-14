class Card {
  String term;
  String definition;
  bool isFavourite = false;
  int id;
  Card({required this.term, required this.definition, required this.id});

  toggleFavourite() {
    isFavourite = !isFavourite;
  }

  get getTerm => term;
  get getDefinitions => definition;
}
