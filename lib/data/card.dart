class Card {
  String term;
  String definition;
  bool isFavourite = false;
  Card({required this.term, required this.definition});
  
  toggleFavourite() {
    isFavourite = !isFavourite;
  }
  get getTerm => term;
  get getDefinitions => definition;

}
