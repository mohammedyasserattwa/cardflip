// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/uncompleted_decks_data/uncompleted_deck_item.dart';
import 'package:cardflip/data/uncompleted_decks_data/uncompleted_decks.dart';
import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/category/category_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/deck_model.dart';
import '../widgets/deck/deck.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final UserModel user = new UserModel();
  final DeckModel deckModel = new DeckModel();
  final RandomGenerator randomCard = new RandomGenerator();
  final List<Map<String, double>> _preferencesSizes = [
    {"width": 127.04, "height": 103.8},
    {"width": 127.04, "height": 125.1},
    {"width": 128.54, "height": 140.18},
    {"width": 128.54, "height": 84.29},
    {"width": 125.04, "height": 103.8},
    {"width": 120.67, "height": 125.1}
  ];
  List<String> preferencesPath() => [
        "Images/cards/homepage/2/2_1/${randomCard.getcolor}/${randomCard.getshape}.png",
        "Images/cards/homepage/2/2_4/${randomCard.getcolor}/${randomCard.getshape}.png",
        "Images/cards/homepage/2/2_2/${randomCard.getcolor}/${randomCard.getshape}.png",
        "Images/cards/homepage/2/2_5/${randomCard.getcolor}/${randomCard.getshape}.png",
        "Images/cards/homepage/2/2_1/${randomCard.getcolor}/${randomCard.getshape}.png",
        "Images/cards/homepage/2/2_4/${randomCard.getcolor}/${randomCard.getshape}.png",
      ];
  Future getUncompletedDecks(String id) async {
    await UncompletedDecks.init(id);
    List<UncompletedDeckItem> result =
        UncompletedDecks.fromJson(UncompletedDecks.uncompletedDecks)
            .where((e) => e.uid == id)
            .toList();
    return deckModel.getDecksByIDs(result.map((e) => e.deckID).toList());
  }

  @override
  Widget build(BuildContext context) {
    final kImagePaths = preferencesPath();
    return Consumer(builder: (context, ref, __) {
      final userData = ref.watch(UserDataProvider);
      return Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/homepage.png"),
              fit: BoxFit.cover),
        ),
        child: NoGlowScroll(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 19, 0, 0),
                child: Stack(
                  children: [
                    Text(
                      "Explore",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "PolySans_Median",
                        color: Color(0xff514F55),
                        fontSize: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/search");
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("Images/icons/search.png"),
                                      fit: BoxFit.cover),
                                ),
                                width: 48,
                                height: 48,
                                child: Text(""))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 14, 0, 0),
                child: Text(
                  "Welcome back, ${userData!.firstname}",
                  style: TextStyle(
                    fontFamily: "PolySans_Median",
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: Text(
                  "Pick up where you left off",
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 21,
                    color: Color(0xff212523),
                  ),
                ),
              ),
              FutureBuilder(
                  future: getUncompletedDecks(userData.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      if (data!.isEmpty) {
                        return SizedBox(
                            height: 116.67,
                            child: Center(
                                child: Text(
                              "No Uncompleted Decks!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 100, 100, 100),
                                fontSize: 20,
                                fontFamily: "Poppins-Medium",
                              ),
                            )));
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
                        child: SizedBox(
                            height: 116.67,
                            child: NoGlowScroll(
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(width: 10),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) => Deck(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/deck", arguments: {
                                            "deck": data[index],
                                            "backhome": true
                                          });
                                          // context.go('/Home/Deck/${index + 1}');
                                        },
                                        deck: data[index],
                                        width: 139,
                                        height: 116.67,
                                        path:
                                            "Images/cards/homepage/1_3/${randomCard.getcolor}/${randomCard.getshape}.png",
                                        min: 3)))),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return SizedBox(
                      height: 116.67,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Text("Based on what you like..",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 21,
                        color: Color(0xff212523))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
                child: SizedBox(
                  height: 237,
                  child: NoGlowScroll(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (int i = 0;
                            i <
                                (userData.userPreferences.length < 6
                                    ? userData.userPreferences.length
                                    : 6);
                            i += 2)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment:
                                  (userData.userPreferences.length > i + 1)
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.start,
                              children: [
                                Deck(
                                    onTap: () {
                                      Navigator.of(context).pushNamed("/deck",
                                          arguments: {
                                            "deck": userData.userPreferences[i],
                                            "backhome": true
                                          });
                                    },
                                    width: _preferencesSizes[i]["width"]!,
                                    height: _preferencesSizes[i]["height"]!,
                                    // id: userData.userPreferences[0].id,
                                    deck: userData.userPreferences[i],
                                    path: kImagePaths[i],
                                    min: 2),
                                SizedBox(
                                  height: 8,
                                ),
                                if (i + 1 < userData.userPreferences.length)
                                  Deck(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/deck", arguments: {
                                          "deck":
                                              userData.userPreferences[i + 1],
                                          "backhome": true
                                        });
                                      },
                                      width: _preferencesSizes[i + 1]["width"]!,
                                      height: _preferencesSizes[i + 1]
                                          ["height"]!,
                                      // id: userData.userPreferences[0].id,
                                      deck: userData.userPreferences[i + 1],
                                      path: kImagePaths[i + 1],
                                      min: 2),
                                // Text("data")
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Text("Categories",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 21,
                        color: Color(0xff212523))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 2, 8),
                child: SizedBox(
                  height: 116.67,
                  child: FutureBuilder(
                      future: deckModel.getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return NoGlowScroll(
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(width: 10),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) => CategoryCard(
                                      category: snapshot.data![index])));
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
