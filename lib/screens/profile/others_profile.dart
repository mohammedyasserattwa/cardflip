import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/widgets/deck/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import 'package:recase/recase.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../models/user_model.dart';

class OthersProfile extends ConsumerWidget {
  final String id;
  OthersProfile({Key? key, required this.id}) : super(key: key);
  final DeckModel deckModel = DeckModel();
  final RandomGenerator cardgenerator = RandomGenerator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserData = ref.watch(UserDataProvider);
    final userData = UserModel().userDataByID(id);
    final userDecks = DeckModel().deckByUserID(id);

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Images/backgrounds/profilepage.png"),
                fit: BoxFit.cover),
          ),
          child: NoGlowScroll(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StickyHeader(
                header: Container(
                  height: 24.0,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: userData,
                        builder: (context, snapshot) {
                          // ugly
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    width: 150,
                                    height: 165,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Images/banners/profilepage/otherpov-light.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 20.0, left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                if (currentUserData!.role ==
                                                    "learner") {
                                                  Navigator.pop(context);
                                                } else if (currentUserData
                                                        .role ==
                                                    "admin") {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/icons/arrow-left-s-line.png"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                  child: const Text(""))),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          top: 0,
                                          bottom: 30,
                                          right: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 20, left: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          274)
                                                      ? 85
                                                      : 55,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width >
                                                              274)
                                                          ? 85
                                                          : 55,
                                                  child: SvgPicture.asset(
                                                      "Images/avatars/${snapshot.data["profileIcon"]}.svg")),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 210,
                                                      child: AutoSizeText(
                                                        maxLines: 2,
                                                        minFontSize: 18,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        stepGranularity: 1,
                                                        ReCase("${snapshot.data["fname"]} ${snapshot.data["lname"]}")
                                                            .titleCase,
                                                        style: TextStyle(
                                                          letterSpacing: 0.5,
                                                          fontFamily:
                                                              "PolySans_Neutral",
                                                          color: Color.fromARGB(
                                                              255, 73, 60, 63),
                                                          fontSize: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "@${snapshot.data["username"]}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "PolySans_Slim",
                                                      color: const Color(
                                                          0xf0493C3F),
                                                      fontSize: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width >
                                                              274)
                                                          ? 17
                                                          : 10,
                                                    ),
                                                  )
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(26, 5, 0, 0),
                      child: Text(
                        "Badges",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: 20,
                            color: Color(0xff212523)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            FutureBuilder(
                                future: userData.then((value) =>
                                    UserModel().getBadgesKeys(value["id"])),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (var i = 0;
                                            i < snapshot.data!.length;
                                            i++)
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "Images/vectors/badges/${snapshot.data![i]}.png"),
                                                      fit: BoxFit.cover),
                                                ),
                                                height: 70,
                                                width: 70,
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                            ],
                                          ),
                                      ],
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xff484848),
                                              fontSize: 20,
                                              fontFamily: "PolySans_Neutral"),
                                          "Something went wrong."),
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(26, 15, 0, 0),
                      child: Text("Decks",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: 20,
                              color: Color(0xff212523))),
                    ),
                    FutureBuilder(
                        future: userDecks,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 140,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 265,
                                    child: Column(
                                      children: [
                                        Text(
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color(0xff484848),
                                                fontSize: 20,
                                                fontFamily: "PolySans_Neutral"),
                                            "Oops! It looks like we hit a snag while loading the user's created decks."),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Don't worry, our team is working on it. In the meantime, why not take a break and come back later?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 82, 82, 82),
                                                fontSize: 15,
                                                fontFamily: "PolySans_Neutral"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                  child: Column(
                                children: [
                                  SizedBox(height: 150),
                                  Text(
                                    "No created decks.",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 100, 100, 100),
                                      fontSize: 20,
                                      fontFamily: "Poppins-Medium",
                                    ),
                                  ),
                                ],
                              ));
                            } else {
                              return Column(
                                children: [
                                  for (int i = 0;
                                      i < snapshot.data!.length;
                                      i += 2)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            (i + 1 < snapshot.data!.length)
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.start,
                                        children: [
                                          FutureBuilder(
                                              future: snapshot.data![i],
                                              builder: (context, deckData) {
                                                if (deckData.hasData) {
                                                  return Deck(
                                                    width: 139,
                                                    height: 116.67,
                                                    deck: deckData.data!,
                                                    path:
                                                        "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                                    min: 2,
                                                    onTap: () {},
                                                  );
                                                }
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }),
                                          if (i + 1 < snapshot.data!.length)
                                            FutureBuilder(
                                                future: snapshot.data![i + 1],
                                                builder: (context, deckData) {
                                                  if (deckData.hasData) {
                                                    return Deck(
                                                      width: 139,
                                                      height: 116.67,
                                                      deck: deckData.data!,
                                                      path:
                                                          "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                                      min: 2,
                                                      onTap: () {},
                                                    );
                                                  }
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }),
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            }
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
