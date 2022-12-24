import 'package:cardflip/data/category.dart';
import "package:cardflip/data/dummy_data.dart";
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';

class CategoryModel {
  DeckModel deckModel = DeckModel();
  UserModel userModel = UserModel();
  String id;
  late Category category;
  CategoryModel({required this.id}) {
    category = userModel.categories.where((element) => element.id == id).first;
  }
}
