class Card {
  String term;
  String definition;
  bool isFavourite = false;
  String id;
  Card({required this.term, required this.definition, required this.id});
  factory Card.fromMap(Map map) {
    return Card(
      id: map['id'],
      term: map['term'],
      definition: map['definition'],
    );
  }

  toggleFavourite() {
    isFavourite = !isFavourite;
  }

  get getTerm => term;
  get getDefinitions => definition;
}
