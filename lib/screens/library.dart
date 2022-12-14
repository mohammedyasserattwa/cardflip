// ignore_for_file: unnecessary_new

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/widgets/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/Repositories/user_state.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../models/deckModel.dart';
// import '../models/libraryModel.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';
import '../data/deck.dart' as DeckData;

class Library extends StatefulWidget {
  const Library({key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  CardGenerator cardgenerator = new CardGenerator();
  DeckModel deckModel = DeckModel();
  late List<DeckData.Deck> favourites;
  late String userID;
  late List<DeckData.Deck> userPersonalDecks;
  List<DeckData.Deck> _currentList = <DeckData.Deck>[];
  late Widget _consumerState;
  Map<String, bool> status = {"all": true, "user": false, "others": false};
  @override
  void initState() {
    _consumerState = createConsumerState();
    super.initState();
  }

  int counter = -1;
  createConsumerState({String state = "all"}) {
    return Consumer(builder: (context, ref, child) {
      final userID = ref.watch(UserIDProvider);
      final favourites = ref.watch(FavouritesProvider);
      final userPersonalDecks = deckModel.deckByUserID(userID);
      for (int i = 0; i < favourites.length; i++) {
        _currentList.add(deckModel.deckByID(favourites[i]));
      }

      if (state == "all") {
        _currentList += userPersonalDecks;
        for (int i = 0; i < favourites.length; i++) {
          _currentList.add(deckModel.deckByID(favourites[i]));
        }
      } else if (state == "user") {
        _currentList = userPersonalDecks;
      }
      EdgeInsets kpaddingCards =
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15);
      return Expanded(
          child: (_currentList.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.not_interested,
                      color: Colors.grey,
                      size: 40,
                    ),
                    Text(
                      "Your library is empty, you can create a new deck or like a deck created by others!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "PolySans_Median",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    )
                  ],
                )
              : NoGlowScroll(
                  child: ListView.builder(
                      itemCount: (_currentList.length > 1)
                          ? _currentList.length ~/ 2
                          : _currentList.length,
                      itemBuilder: (context, i) {
                        if (counter + 1 < _currentList.length) counter++;
                        return Padding(
                          padding: kpaddingCards,
                          child: Row(
                            mainAxisAlignment:
                                (i + counter + 1 < _currentList.length)
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.start,
                            children: [
                              Deck(
                                  id: _currentList[i + counter].id,
                                  width: _responsive(context)["width"],
                                  height: _responsive(context)["height"],
                                  min: 3,
                                  onTap: () {
                                    GoRouter.of(context).go(
                                        '/Home/Library/Deck/${_currentList[i + counter].id}');
                                  },
                                  path:
                                      "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                              if (i + counter + 1 < _currentList.length)
                                Deck(
                                    id: _currentList[i + counter + 1].id,
                                    width: _responsive(context)["width"],
                                    height: _responsive(context)["height"],
                                    min: 3,
                                    onTap: () {
                                      GoRouter.of(context).go(
                                          '/Home/Library/Deck/${_currentList[i + counter + 1].id}');
                                    },
                                    path:
                                        "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                            ],
                          ),
                        );
                      })));
    });
  }

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
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/librarypage.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "Images/banners/librarypage/${cardgenerator.librarycolor}.png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: 400,
              height: 190,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 20),
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/more-fill.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Text(""))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Library",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: "PolySans_Median",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (!status["all"]!) {
                          status["all"] = true;
                          status["user"] = false;
                          status["others"] = false;
                          setState(() {
                            _currentList = <DeckData.Deck>[];
                            _consumerState = createConsumerState();
                            counter = 0;
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: (status["all"]!)
                                  ? Color.fromARGB(31, 10, 1, 1)
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          width: 48,
                          height: 48,
                          child: Center(
                              child: Text(
                            "All",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "PolySans",
                                fontWeight: (status["all"]! == true)
                                    ? FontWeight.w600
                                    : FontWeight.normal),
                          )))),
                  GestureDetector(
                    onTap: () {
                      if (!status["user"]!) {
                        status["all"] = false;
                        status["user"] = true;
                        status["others"] = false;
                        setState(() {
                          _currentList = <DeckData.Deck>[];
                          _consumerState = createConsumerState(state: "user");
                          counter = 0;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (status["user"]!)
                              ? Color.fromARGB(31, 10, 1, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          "Yours",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "PolySans_Neutral",
                              fontWeight: (status["user"]!)
                                  ? FontWeight.w600
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!status["others"]!) {
                        status["all"] = false;
                        status["user"] = false;
                        status["others"] = true;
                        setState(() {
                          _currentList = <DeckData.Deck>[];
                          _consumerState = createConsumerState(state: "others");
                          counter = 0;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (status["others"]!)
                              ? Color.fromARGB(31, 10, 1, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 55,
                      height: 48,
                      child: Center(
                        child: Text(
                          "Others",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "PolySans_Neutral",
                              fontWeight: (status["others"]!)
                                  ? FontWeight.w600
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/Home/Library/Adddeck');
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/add.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/filter.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                ],
              ),
            ),
            _consumerState
          ],
        ),
      ),
    );
  }
}
