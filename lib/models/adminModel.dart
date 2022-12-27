import '../data/dummy_data.dart';

class AdminModel{
  String username="admin";
  String password="cardFlip12345";
  String name="Admin";
  List<String> reports=[];
  List<String> decks=[];
  List<String> users=[];

  final DummyData _data;
  AdminModel(DummyData data) : _data = data;

  String get fname{
    return _data.username;
  }

  void banDeck(String name){
    decks.remove(name);
  }
  void viewReports(){
    for (var i =0;i<reports.length;i++){
      print (reports[i]+'\n');
    }
  }
  void viewDecks(){
    for (var i =0;i<decks.length;i++){
      print (decks[i]+'\n');
    }
  }
  void viewUsers(){
    for (var i =0;i<users.length;i++){
      print (users[i]+'\n');
    }
  }
  
}