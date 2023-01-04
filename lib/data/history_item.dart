import 'dart:convert';

class HistoryItem {
  String uid;
  String query;
  HistoryItem({
    required this.uid,
    required this.query,
  });
  String toJson() {
    return json.encode({
      "uid": uid,
      "query": query,
    });
  }

  static fromJson(String data) {
    final jsonData = json.decode(data);
    print(jsonData["uid"]);
    return HistoryItem(
      uid: jsonData["uid"],
      query: jsonData["query"],
    );
  }
}
