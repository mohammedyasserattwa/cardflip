class Deck{
  String name="";
  String image="";
  String description="";
  int rating=0;
  List<Flashcard> _Cards=[];
  double progress = 0.0;

  Deck(){
    name = "";
    image = "";
    description = "";
    rating = 0;
    _Cards = [];
    progress = 0.0;
  }
  double calculateProgress(){
    return progress;
  }
  void randomize(){

  }
  int addRating(){
    rating++;
    return rating;
  }
  int subtractRating(){
    rating--;
    return rating;
  }
  void addCard(Flashcard Card){
    _Cards.add(Card);
  }
  void removeCard(Flashcard Card){
    _Cards.remove(Card);
  }
  void editCard(){

  }
}
class Flashcard{
  String term="";
  String definition="";
  String status="";
  String type="";

  Flashcard(){
    term="";
    definition="";
    status="";
    type="";
  }
}

class Test{
  List<Question> questions=[];
  int time=0;
  //   (((((Leaderboard)))))
  Test(){
    questions=[];
    time=0;
  }
}
class Question{
  String question="";
  //  (((((Answer)))))
  String type="";
  List<String>choices=[];
}

class Answer{
  String answer="";
}