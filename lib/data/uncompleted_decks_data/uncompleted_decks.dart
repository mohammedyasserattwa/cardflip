import 'package:cardflip/data/uncompleted_decks_data/uncompleted_deck_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UncompletedDecks {
  static String uncompletedDecks = "{}";
  static SharedPreferences? _prefs;
  static init(String id) async {
    _prefs = await SharedPreferences.getInstance();
    // _prefs!.clear();
    uncompletedDecks = _prefs!.getString("uncompleted_decks_$id") ?? "{}";
  }

  static toJson(List<UncompletedDeckItem> data) {
    return json.encode(data);
  }

  static List<UncompletedDeckItem> fromJson(String data) {
    try {
      final jsonData = json.decode(data) as List;
      return List.from(jsonData.map((e) => UncompletedDeckItem.fromJson(e)));
    } catch (e) {
      return [];
    }
  }
}
