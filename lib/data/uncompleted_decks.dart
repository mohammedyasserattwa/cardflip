import 'package:cardflip/data/uncompleted_deck_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UncompletedDecks {
  static String uncompletedDecks = "{}";
  static SharedPreferences? _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
    uncompletedDecks = _prefs!.getString("uncompletedDecks2") ?? "{}";
  }

  static toJson(List<UncompletedDeckItem> data) {
    return json.encode(data);
  }

  static List<UncompletedDeckItem> fromJson(String data) {
    final jsonData = json.decode(data) as List;
    return List.from(jsonData.map((e) => UncompletedDeckItem.fromJson(e)));
  }
}
