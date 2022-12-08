import "package:cardflip/data/dummy_data.dart";

class LibraryModel {
  List<String>decks=[];
  void addDeck(String name){
    decks.add(name);
  }
  void deleteDeck(String name){
    decks.remove(name);
  }
  void createDeck(){
    
  }

  
}
