// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/uncompleted_deck_item.dart';
import 'package:cardflip/data/uncompleted_decks.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/screens/loading_screen.dart';
import 'package:cardflip/widgets/category_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/deckModel.dart';
import '../models/homeModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../widgets/deck.dart';
import '../widgets/navibar.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  Home({super.key});
  UserModel user = new UserModel();
  DeckModel deckModel = new DeckModel();
  CardGenerator randomCard = new CardGenerator();
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

  @override
  Widget build(BuildContext context) {
    final _kImagePaths = preferencesPath();
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
                  future:
                      ref.watch(UnCompletedDecksProvider).then((value) async {
                    await UncompletedDecks.init();
                    List<UncompletedDeckItem> result =
                        UncompletedDecks.fromJson(
                                UncompletedDecks.uncompletedDecks)
                            .where((e) => e.uid == userData.id)
                            .toList();
                    return deckModel
                        .getDecksByIDs(result.map((e) => e.deckID).toList());
                  }),
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
                    return Center(
                      child: CircularProgressIndicator(),
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
                            i < userData.userPreferences.length;
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
                                      Navigator.of(context)
                                          .pushNamed("/deck", arguments: {
                                        "deck": userData.userPreferences[i],
                                      });
                                    },
                                    width: _preferencesSizes[i]["width"]!,
                                    height: _preferencesSizes[i]["height"]!,
                                    // id: userData.userPreferences[0].id,
                                    deck: userData.userPreferences[i],
                                    path: _kImagePaths[i],
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
                                        });
                                      },
                                      width: _preferencesSizes[i + 1]["width"]!,
                                      height: _preferencesSizes[i + 1]
                                          ["height"]!,
                                      // id: userData.userPreferences[0].id,
                                      deck: userData.userPreferences[i + 1],
                                      path: _kImagePaths[i + 1],
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
