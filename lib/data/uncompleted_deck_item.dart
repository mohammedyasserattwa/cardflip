import 'dart:convert';

class UncompletedDeckItem {
  String uid;
  String deckID;
  UncompletedDeckItem({
    required this.uid,
    required this.deckID,
  });
  String toJson() {
    return json.encode({
      "uid": uid,
      "deckID": deckID,
    });
  }
  static fromJson(String data){
    final jsonData = json.decode(data);
    return UncompletedDeckItem(
      uid: jsonData["uid"],
      deckID: jsonData["deckID"],
    );
  }
}
