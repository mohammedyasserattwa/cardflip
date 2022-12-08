class AdminModel{
  String username="admin";
  String password="cardFlip12345";
  String name="Admin";
  List<String> reports=[];
  List<String> decks=[];
  void banDeck(int id){
    decks.remove(id);
  }
  
}