import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/widgets/deck/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import 'package:recase/recase.dart';

import '../models/user_model.dart';

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
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/profilepage.png"),
              fit: BoxFit.cover),
        ),
        child: NoGlowScroll(
          child: ListView(
            children: [
              FutureBuilder(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 20.0, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      if (currentUserData!.role == "learner") {
                                        Navigator.pop(context);
                                      } else if (currentUserData.role ==
                                          "admin") {
                                        Navigator.pop(context);
                                      }
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
                                  child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width >
                                                  274)
                                              ? 85
                                              : 55,
                                      height:
                                          (MediaQuery.of(context).size.width >
                                                  274)
                                              ? 85
                                              : 55,
                                      child: SvgPicture.asset(
                                          "Images/avatars/${snapshot.data["profileIcon"]}.svg")),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ReCase("${snapshot.data["fname"]} ${snapshot.data["lname"]}")
                                            .titleCase,
                                        style: TextStyle(
                                          fontFamily: "PolySans_Slim",
                                          color: const Color(0xf0493C3F),
                                          fontSize: (MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  300)
                                              ? 32
                                              : 25,
                                        ),
                                      ),
                                      Text(
                                        "@${snapshot.data["username"]}",
                                        style: TextStyle(
                                          fontFamily: "PolySans_Slim",
                                          color: const Color(0xf0493C3F),
                                          fontSize: (MediaQuery.of(context)
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
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
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
              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FutureBuilder(
                        future: userData.then(
                            (value) => UserModel().getBadgesKeys(value["id"])),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var i = 0; i < snapshot.data!.length; i++)
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
                                        width: 30,
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(26, 15, 0, 0),
                child: Text("Decks",
                    style:
                        TextStyle(fontFamily: "Poppins-Medium", fontSize: 17)),
              ),
              FutureBuilder(
                  future: userDecks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data!.length; i += 2)
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
                                            child: CircularProgressIndicator());
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
                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
