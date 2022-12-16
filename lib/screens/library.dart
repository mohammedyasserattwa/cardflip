// ignore_for_file: unnecessary_new
import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/widgets/deck.dart';
import 'package:cardflip/widgets/library_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/Repositories/user_state.dart';
import '../data/card_generator.dart';
import '../models/deckModel.dart';
import '../widgets/navibar.dart';
import '../data/deck.dart' as deck_data;

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late CardGenerator cardgenerator;
  late DeckModel deckModel;
  List<deck_data.Deck> _currentList = <deck_data.Deck>[];
  late Widget _consumerState;
  late AssetImage _banner;
  late Widget _header;
  Map<String, bool> status = {"all": true, "user": false, "others": false};
  late List<Widget> _listBuilder;
  @override
  void initState() {
    deckModel = DeckModel();
    cardgenerator = new CardGenerator();
    _banner = AssetImage(
        "Images/banners/librarypage/${cardgenerator.librarycolor}.png");
    _header = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _banner,
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
                                image: AssetImage("Images/icons/more-fill.png"),
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
    );
    _listBuilder = [
      LibraryList().build(),
      LibraryList().build(state: "user"),
      LibraryList().build(state: "others")
    ];
    // print(deckList);
    _consumerState = _listBuilder[0];
    super.initState();
  }

  bool _isFiltered = false;

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
            _header,
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
                          _consumerState = _listBuilder[0];
                          setState(() {});
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: (status["all"]!)
                                  ? const Color.fromARGB(31, 10, 1, 1)
                                  : Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
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
                        _consumerState = _listBuilder[1];
                        setState(() {
                          // _consumerState = _listBuilder["user"]!;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (status["user"]!)
                              ? const Color.fromARGB(31, 10, 1, 1)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
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
                        _consumerState = _listBuilder[2];
                        setState(() {
                          // _consumerState = _listBuilder["others"]!;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (status["others"]!)
                              ? const Color.fromARGB(31, 10, 1, 1)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
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
                            child: const Text(""))),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          if (!_isFiltered) {
                            setState(() {
                              _consumerState =
                                  LibraryList(filter: true).build();
                              _isFiltered = true;
                            });
                          } else {
                            setState(() {
                              _consumerState =
                                  LibraryList(filter: false).build();
                              _isFiltered = false;
                            });
                          }
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/filter.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: const Text(""))),
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
