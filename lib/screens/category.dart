// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cardflip/main.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/categoryModel.dart';
import '../data/card_generator.dart';
import '../data/category.dart' as CategoryData;
import '../widgets/deck.dart';
import '../widgets/navibar.dart';
import 'package:go_router/go_router.dart';

class Category extends StatelessWidget {
  String id;
  Category({super.key, required this.id});

  CardGenerator cardgenerator = new CardGenerator();
  CardGenerator cardgenerator2 = new CardGenerator();
  CardGenerator cardgenerator3 = new CardGenerator();
  final navItems = {"Home", "Library", "Account"};
  final navIcons = {
    const Icon(Icons.home_rounded),
    const Icon(Icons.library_books_outlined),
    const Icon(Icons.person_outline)
  };
  _responsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < 299) {
      return {"height": 113.67, "width": 118.67, "fontSize": 16};
    } else if (MediaQuery.of(context).size.width < 340) {
      return {"height": 128.67, "width": 133.67, "fontSize": 20};
    } else if (MediaQuery.of(context).size.width < 358) {
      return {"height": 148.67, "width": 153.67, "fontSize": 20};
    } else {
      return {"height": 158.67, "width": 163.67, "fontSize": 20};
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryModel model = new CategoryModel(id: id);
    final height = _responsive(context)["height"];
    final width = _responsive(context)["width"];
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(model.category.background),
                  fit: BoxFit.cover),
            ),
            child: NoGlowScroll(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/arrow-left-s-line.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Text(""))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(model.category.vector),
                              fit: BoxFit.cover,
                              scale: 0.5,
                            ),
                          ),
                          width: 329,
                          height: 298,
                          // width: 475.27,
                          // height: 350.41,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          model.category.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            // fontFamily: "PolySans_Median",
                            fontFamily: "Poppins-SemiBold",
                            color: Color.fromARGB(255, 17, 17, 17),
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    for (int i = 0; i < model.category.decks.length; i += 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment:
                              (i + 1 < model.category.decks.length)
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.start,
                          children: [
                            Deck(
                              height: height,
                              id: model.category.decks[i].id,
                              width: width,
                              path:
                                  "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                              min: 3,
                              onTap: () => Navigator.of(context)
                                  .pushNamed("/deck", arguments: {
                                "deckID": model.category.decks[i].id,
                              }),
                            ),
                            if (i + 1 < model.category.decks.length)
                              Deck(
                                height: height,
                                width: width,
                                id: model.category.decks[i + 1].id,
                                path:
                                    "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                min: 3,
                                onTap: () => Navigator.of(context)
                                    .pushNamed("/deck", arguments: {
                                  "deckID": model.category.decks[i + 1].id,
                                }),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ]),
            )));
  }
}
