import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/deck.dart' as deck_data;
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/widgets/deck/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import 'package:recase/recase.dart';
import '../../helpers/random_generator.dart';

class Profile extends ConsumerWidget {
  Profile({super.key});
  // TODO: ADD the leaderboard model here
  DeckModel deckModel = DeckModel();
  RandomGenerator cardgenerator = RandomGenerator();
  late String profileBanner;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(UserDataProvider);
    final height = _responsive(context)["height"];
    final width = _responsive(context)["width"];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Images/backgrounds/profilepage.png"),
            fit: BoxFit.cover),
      ),
      child: NoGlowScroll(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/settings");
                        },
                        child: SvgPicture.asset(
                          "Images/icons/svg/settings.svg",
                          width: 25,
                          height: 25,
                          color: Color(0xff8C9595),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 15, bottom: 30, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: (MediaQuery.of(context).size.width > 274)
                                ? 85
                                : 55,
                            height: (MediaQuery.of(context).size.width > 274)
                                ? 85
                                : 55,
                            child: SvgPicture.asset(
                                "Images/avatars/${userData!.profileIcon}.svg")),
                      ),
                      const SizedBox(width: 5),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                ReCase("${userData.fname} ${userData.lname}")
                                    .titleCase,
                                style: TextStyle(
                                  fontFamily: "PolySans_Slim",
                                  color: const Color(0xf0493C3F),
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 300)
                                          ? 32
                                          : 25,
                                ),
                              ),
                            ),
                            Text(
                              "@${userData.username}",
                              style: TextStyle(
                                fontFamily: "PolySans_Slim",
                                color: Color(0xf0493C3F),
                                fontSize:
                                    (MediaQuery.of(context).size.width > 274)
                                        ? 17
                                        : 10,
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/editprofile");
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("Images/icons/editprofile.png"),
                                fit: BoxFit.cover),
                          ),
                          width: 103,
                          height: 34,
                          child: const Center(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "Poppins-Medium"),
                            ),
                          ))),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 10, 0, 0),
              child: Text(
                "Badges",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/badges1.png"),
                          fit: BoxFit.cover),
                    ),
                    height: 55,
                    width: 55,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/badges2.png"),
                          fit: BoxFit.cover),
                    ),
                    height: 55,
                    width: 55,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/badges3.png"),
                          fit: BoxFit.cover),
                    ),
                    height: 55,
                    width: 55,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/morebadges.png"),
                          fit: BoxFit.cover),
                    ),
                    height: 55,
                    width: 55,
                    child: const Center(
                      child: Text(
                        "+32",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins-SemiBold",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 10, 0, 0),
              child: Text(
                "Recent Decks",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 17,
                  // color: Color(0xff212523),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
              child: SizedBox(
                height: height,
                child: FutureBuilder(
                    future: deckModel.getRecentlyAddedDecks(userData.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final decks = snapshot.data!;
                        if (decks.isNotEmpty) {
                          return NoGlowScroll(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: decks.length,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  FutureBuilder(
                                      future: decks[index],
                                      builder: (context, deckData) {
                                        if (deckData.hasData) {
                                          return Deck(
                                              width: 139,
                                              height: 116.67,
                                              path:
                                                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                              min: 3,
                                              deck: deckData.data!,
                                              onTap: () => Navigator.pushNamed(
                                                    context,
                                                    "/deck",
                                                    arguments: {
                                                      "deck": deckData.data!,
                                                    },
                                                  ));
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }),
                                  const SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text(
                            "No decks found",
                            style: TextStyle(
                              color: Color.fromARGB(255, 100, 100, 100),
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ));
                        }
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 15, 0, 0),
              child: Text("Top Rated Decks",
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 17,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
              child: SizedBox(
                height: height,
                child: FutureBuilder(
                    future: deckModel.getTopRatedDecks(userData.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text(
                            "No decks found",
                            style: TextStyle(
                              color: Color.fromARGB(255, 100, 100, 100),
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ));
                        } else {
                          return NoGlowScroll(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  FutureBuilder(
                                      future: snapshot.data![index],
                                      builder: (context, deck) {
                                        if (deck.hasData) {
                                          return Deck(
                                            width: 139,
                                            height: 116.67,
                                            path:
                                                "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                            deck: deck.data!,
                                            min: 3,
                                            onTap: (() => Navigator.pushNamed(
                                                  context,
                                                  "/deck",
                                                  arguments: {
                                                    "deck": deck.data!,
                                                  },
                                                )),
                                          );
                                        }
                                        if (deck.hasError) {
                                          return Text("${deck.error}");
                                        }
                                        return Container();
                                      }),
                                  const SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 15, 0, 0),
              child: Text("Leaderboard",
                  style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
              child: SizedBox(
                height: height,
                child: FutureBuilder(
                    future: deckModel.getDeckByLeaderboardUserID(userData.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!["data"].length == 0) {
                          return const Center(
                              child: Text(
                            "No decks found",
                            style: TextStyle(
                              color: Color.fromARGB(255, 100, 100, 100),
                              fontSize: 20,
                              fontFamily: "Poppins-Medium",
                            ),
                          ));
                        } else {
                          return NoGlowScroll(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!["data"].length,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  FutureBuilder(
                                      future: snapshot.data!["data"][index],
                                      builder: (context, deck) {
                                        if (deck.hasError) {
                                          return Text("${deck.error}");
                                        }
                                        if (deck.hasData) {
                                          return Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Deck(
                                                    width: 139,
                                                    height: 116.67,
                                                    path:
                                                        "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png",
                                                    deck: deck.data!
                                                        as deck_data.Deck?,
                                                    min: 3,
                                                    onTap: (() =>
                                                        Navigator.pushNamed(
                                                          context,
                                                          "/deck",
                                                          arguments: {
                                                            "deck": deck.data!,
                                                          },
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 139,
                                                height: 146.67,
                                                // color: Colors.red,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "Images/icons/svg/rank${snapshot.data!["leaderboard"][index].where((element) => element["userID"] == userData.id).first["rank"]}.svg",
                                                      width: 35,
                                                      height: 40,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        if (deck.hasError) {
                                          return Text("${deck.error}");
                                        }
                                        return Container();
                                      }),
                                  const SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
