
import 'package:cardflip/data/search_history_data/history_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class History {
  static String history = "{}";
  static SharedPreferences? _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
    history = _prefs!.getString("historyData3") ?? "{}";
  }

  static toJson(List<HistoryItem> data) {
    return json.encode(data.map((e) => e.toJson()).toList());
  }

  static List<HistoryItem> fromJson(String data) {
    final jsonData = json.decode(data) as List;
    
    return List.from(jsonData.map((e) => HistoryItem.fromJson(e)));
  }
}
