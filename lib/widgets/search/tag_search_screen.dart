import 'package:cardflip/data/deck.dart';
import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/widgets/search/search_deck_item.dart';
import "package:cardflip/widgets/deck/deck.dart" as deck_ui;
import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:recase/recase.dart';

class TagScreen extends StatefulWidget {
  final dynamic tags;

  TagScreen({super.key, required this.tags});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  Future<List<Future<Deck>>> _resultDecks = Future.value([]);
  RandomGenerator randomizer = RandomGenerator();
  String _chosenTag = "";
  String _chosenTagId = "";
  List<bool> _tagActive = [];
  bool _viewAll = false;
  final BoxDecoration _inactiveTagDecoration = BoxDecoration(
    border:
        Border.all(color: const Color.fromARGB(255, 175, 175, 175), width: 1),
    borderRadius: BorderRadius.circular(16),
    color: const Color(0x8FDADADA),
  );
  final BoxDecoration _activeTagDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xffA000A4), width: 1),
    borderRadius: BorderRadius.circular(16),
    color: Color.fromARGB(169, 244, 177, 235),
  );
  @override
  void initState() {
    _tagActive = List.filled(widget.tags.length, false);
    super.initState();
  }

  int c2 = 0;
  Map<String, List<deck_ui.Deck>> _renderedDecks = {};
  @override
  Widget build(BuildContext context) {
    return (widget.tags.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NoGlowScroll(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (int i = 0;
                              i < (_viewAll ? widget.tags.length : 12);
                              i += 4)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int j = i; //0 -> 3<3
                                    j <
                                        ((widget.tags.length > i + 4)
                                            ? i + 4
                                            : widget.tags.length);
                                    j++)
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // _tagActive[j] = !_tagActive[j];
                                          int c = 0;
                                          _tagActive = _tagActive.map((e) {
                                            if (c++ != j) {
                                              return false;
                                            } else {
                                              return !e;
                                            }
                                          }).toList();
                                          if (_tagActive[j] == true) {
                                            _resultDecks = DeckModel()
                                                .deckByTagID(
                                                    widget.tags[j].tagID);
                                            _chosenTagId = widget.tags[j].tagID;
                                            _chosenTag = widget.tags[j].name;
                                            // if (_renderedDecks
                                            //     .containsKey(_chosenTagId)) {
                                            //   _renderedDecks[_chosenTagId] = [];
                                            // } else {
                                            // _renderedDecks
                                            //     .addAll({_chosenTagId: []});
                                            // }
                                            // print(_renderedDecks);
                                          } else {
                                            _resultDecks = Future.value([]);
                                            _chosenTag = "";
                                            _chosenTagId = "";
                                          }
                                        });
                                        // setState(() {});
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: _tagActive[j]
                                              ? _activeTagDecoration
                                              : _inactiveTagDecoration,
                                          child: Center(
                                            child: Text(
                                                ReCase(widget.tags[j].name)
                                                    .titleCase,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      "PolySans_Neutral",
                                                  fontSize: 15,
                                                )),
                                          )),
                                    ),
                                  ),
                              ],
                            )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _viewAll = !_viewAll;
                          });
                        },
                        child: Text(
                          (_viewAll) ? "Shorten the list" : "View all tags",
                          style: const TextStyle(
                            fontFamily: "PolySans_Regular",
                            fontSize: 16,
                            color: Color(0xff212523),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
                if (_chosenTagId.isNotEmpty)
                  if (!_renderedDecks.containsKey(_chosenTagId))
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                      child: Column(
                        children: [
                          Text(
                            "Showing the results of the tag: ${ReCase(_chosenTag).titleCase}",
                            style: const TextStyle(
                              fontFamily: "PolySans_Neutral",
                              fontSize: 20,
                              color: Color(0xff212523),
                            ),
                          ),
                          displayDecks(),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: NoGlowScroll(
                          child: ListView(
                            children: [
                              Text(
                                "Showing the results of the tag: ${ReCase(_chosenTag).titleCase}",
                                style: const TextStyle(
                                  fontFamily: "PolySans_Neutral",
                                  fontSize: 20,
                                  color: Color(0xff212523),
                                ),
                              ),
                              if (_renderedDecks[_chosenTagId]!.isEmpty)
                                const SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Text(
                                      "The chosen tag has no decks yet",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "PolySans_Neutral",
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              for (int i = 0;
                                  i < _renderedDecks[_chosenTagId]!.length;
                                  i += 2)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: (i + 1 <
                                            _renderedDecks[_chosenTagId]!.length)
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.start,
                                    children: [
                                      _renderedDecks[_chosenTagId]![i],
                                      if (i + 1 <
                                          _renderedDecks[_chosenTagId]!.length)
                                        _renderedDecks[_chosenTagId]![i + 1],
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                if (_chosenTagId.isEmpty)
                  const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        "Choose one of the tags above to view the decks",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "PolySans_Neutral",
                          fontSize: 25,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          )
        : Expanded(
            // height: 116.67,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "No Tags found",
                  style: TextStyle(
                    fontFamily: "PolySans_Median",
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Color.fromARGB(255, 73, 75, 74),
                  ),
                ),
              ],
            ),
          );
  }

  FutureBuilder<List<Future<Deck>>> displayDecks() {
    _renderedDecks.addAll({_chosenTagId: []});
    return FutureBuilder(
        future: DeckModel().deckByTagID(_chosenTagId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  "${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "PolySans_Neutral",
                    fontSize: 25,
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final decks = snapshot.data;
            return (decks!.isEmpty)
                ? const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        "The chosen tag has no decks yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "PolySans_Neutral",
                          fontSize: 25,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: viewDecks(decks),
                  );
          }
          if (snapshot.hasError) {
            return SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  "Something went wrong${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "PolySans_Neutral",
                    fontSize: 25,
                  ),
                ),
              ),
            );
          }
          return const SizedBox(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  List<Widget> viewDecks(List<Future<Deck>> decks) {
    List<Widget> deckWidgets = [];
    List<deck_ui.Deck> deckUI = [];
    for (int i = 0; i < decks.length; i += 2) {
      deckWidgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: (i + 1 < decks.length)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              FutureBuilder(
                future: decks[i],
                builder: (context, deckData) {
                  if (deckData.hasData) {
                    final ui = deck_ui.Deck(
                      height: 116.67,
                      width: 139,
                      deck: deckData.data!,
                      path:
                          "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png",
                      min: 3,
                      onTap: () {
                        Navigator.pushNamed(context, "/deck",
                            arguments: {"deck": deckData.data!});
                      },
                    );
                    // _renderedDecks[_chosenTagId]!.add(ui);
                    deckUI.add(ui);
                    if (i + 1 > decks.length || decks.length == 1) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // if (c2 > 0) {
                        setState(() {
                          _renderedDecks[_chosenTagId]!.addAll(deckUI);
                        });
                        // }
                      });
                    }
                    return ui;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              if (i + 1 < decks.length)
                FutureBuilder(
                  future: decks[i + 1],
                  builder: (context, deckData) {
                    if (deckData.hasData) {
                      final ui = deck_ui.Deck(
                        height: 116.67,
                        width: 139,
                        deck: deckData.data!,
                        path:
                            "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png",
                        min: 3,
                        onTap: () {
                          Navigator.pushNamed(context, "/deck",
                              arguments: {"deck": deckData.data!});
                        },
                      );
                      // _renderedDecks[_chosenTagId]!.add(ui);
                      deckUI.add(ui);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // if (c2 > 0) {
                        setState(() {
                          _renderedDecks[_chosenTagId]!.addAll(deckUI);
                        });
                        // }
                      });
                      return ui;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
            ],
          ),
        ),
      );
    }
    // _renderedDecks[_chosenTagId]!.clear();
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   setState(() {
    //     _renderedDecks[_chosenTagId] = (deckUI);
    //   });
    // });

    return deckWidgets;
  }
}
