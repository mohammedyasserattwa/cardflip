import 'package:cardflip/data/Repositories/search_provider.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/deck/deck_search_screen.dart';
import 'package:cardflip/widgets/search/people_search_screen.dart';
import 'package:cardflip/widgets/search/search_deck_item.dart';
import 'package:cardflip/widgets/search/tag_search_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:recase/recase.dart';

class SearchResult extends ConsumerStatefulWidget {
  String query;
  SearchResult({super.key, required this.query});

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  DeckModel deckModel = DeckModel();
  UserModel userModel = UserModel();
  List<bool> _currentPage = [true, false, false, false];
  late Widget _currentState;
  _resetPages() {
    for (int i = 0; i < _currentPage.length; i++) {
      _currentPage[i] = false;
    }
  }

  Future getData() async {
    return {
      "decks": await deckModel.decksByQuery(widget.query),
      "tags": await deckModel.tagsByQuery(widget.query),
      "people": await userModel.userByQuery(widget.query),
    };
  }

  final _textStyle = const TextStyle(
    fontFamily: "PolySans_Neutral",
    fontSize: 24,
    color: Color(0xAf1A0404),
  );
  final _activeDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: const Color(0x1f1A0404),
  );
  final _inactiveDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.transparent,
  );
  int counter = 0;
  Future<void> executeAfterBuild(dynamic decks) async {
    ref.read(sortProvider.notifier).state = decks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final decks = snapshot.data["decks"];
            final tags = snapshot.data["tags"];
            final people = snapshot.data["people"];

            if (counter++ == 0) {
              executeAfterBuild(decks);
              _currentState =
                  AllScreen(decks: decks, tags: tags, people: people, onTap: [
                () {
                  setState(() {
                    _resetPages();
                    _currentPage[1] = true;
                    _currentState = DeckSearchScreen(decks: decks);
                  });
                },
                () {
                  setState(() {
                    _resetPages();
                    _currentPage[2] = true;
                    _currentState = TagScreen(tags: tags);
                  });
                },
                () {
                  setState(() {
                    _resetPages();
                    _currentPage[3] = true;
                    _currentState = PeopleScreen(people: people);
                  });
                }
              ]);
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!_currentPage[0]) {
                          setState(() {
                            _resetPages();
                            _currentPage[0] = true;
                            _currentState = AllScreen(
                                decks: decks,
                                tags: tags,
                                people: people,
                                onTap: [
                                  () {
                                    setState(() {
                                      _resetPages();
                                      _currentPage[1] = true;
                                      _currentState =
                                          DeckSearchScreen(decks: decks);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      _resetPages();
                                      _currentPage[2] = true;
                                      _currentState = TagScreen(tags: tags);
                                    });
                                  },
                                  () {
                                    setState(() {
                                      _resetPages();
                                      _currentPage[3] = true;
                                      _currentState =
                                          PeopleScreen(people: people);
                                    });
                                  }
                                ]);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: (_currentPage[0])
                                ? _activeDecoration
                                : _inactiveDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Center(child: Text("All", style: _textStyle)),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_currentPage[1]) {
                          setState(() {
                            _resetPages();
                            _currentPage[1] = true;
                            _currentState = DeckSearchScreen(decks: decks);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: (_currentPage[1])
                              ? _activeDecoration
                              : _inactiveDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Decks", style: _textStyle),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_currentPage[2]) {
                          setState(() {
                            _resetPages();
                            _currentPage[2] = true;
                            _currentState = TagScreen(tags: tags);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: (_currentPage[2])
                              ? _activeDecoration
                              : _inactiveDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Tags", style: _textStyle),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!_currentPage[3]) {
                          setState(() {
                            _resetPages();
                            _currentPage[3] = true;
                            _currentState = PeopleScreen(people: people);
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: (_currentPage[3])
                              ? _activeDecoration
                              : _inactiveDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("People", style: _textStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _currentState
              ],
            );
          }
          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));
          return Center(child: CircularProgressIndicator());
        });
  }
}

class AllScreen extends ConsumerWidget {
  dynamic decks;
  dynamic tags;
  dynamic people;
  List<Function> onTap;
  AllScreen(
      {required this.decks,
      required this.tags,
      required this.people,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: NoGlowScroll(
      child: ListView(padding: EdgeInsets.zero, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Decks",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xff212523),
                ),
              ),
              GestureDetector(
                onTap: (() {}),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    color: Color(0xff212523),
                  ),
                ),
              )
            ],
          ),
        ),
        if (decks.isNotEmpty)
          SizedBox(
            height: 116.67,
            child: NoGlowScroll(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: ref.watch(sortProvider).length > 3
                    ? 3
                    : ref.watch(sortProvider).length,
                itemBuilder: (context, index) {
                  return SearchDeckItem(
                      name: ref.watch(sortProvider)[index]["name"]);
                },
              ),
            ),
          )
        else
          const SizedBox(
            height: 116.67,
            child: Center(
              child: Text(
                "No decks found",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color.fromARGB(255, 73, 75, 74),
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Tags",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xff212523),
                ),
              ),
              GestureDetector(
                onTap: (() {}),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    color: Color(0xff212523),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (tags.isNotEmpty)
          NoGlowScroll(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("${(tags.length)}"),
                    for (int i = 0;
                        i < (tags.length > 12 ? 12 : tags.length);
                        i += 4)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = i; //0 -> 3<3
                              j < ((tags.length > i + 4) ? i + 4 : tags.length);
                              j++)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 175, 175, 175),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color(0x8FDADADA),
                                  ),
                                  child: Text(ReCase(tags[j].name).titleCase)),
                            ),
                        ],
                      )
                  ]),
            ),
          )
        else
          const SizedBox(
            height: 116.67,
            child: Center(
              child: Text(
                "No Tags found",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color.fromARGB(255, 73, 75, 74),
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "People",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xff212523),
                ),
              ),
              GestureDetector(
                onTap: (() {}),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontSize: 16,
                    color: Color(0xff212523),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (people.isNotEmpty)
          NoGlowScroll(
              child: SingleChildScrollView(
            child: Column(children: [
              for (int index = 0; index < people.length; index++)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          "Images/avatars/${people[index]["profileIcon"]}.svg",
                          height: 47.4,
                          width: 47.4),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            people[index]["fname"] +
                                " " +
                                people[index]["lname"],
                            style: const TextStyle(
                              fontFamily: "PolySans_Neutral",
                              fontSize: 20,
                              color: Color(0xff212523),
                            ),
                          ),
                          Text(
                            "@" + people[index]["username"],
                            style: const TextStyle(
                              fontFamily: "Poppins-Light",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff212523),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ]),
          ))
        else
          const SizedBox(
            height: 116.67,
            child: Center(
              child: Text(
                "No People found",
                style: TextStyle(
                  fontFamily: "PolySans_Median",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color.fromARGB(255, 73, 75, 74),
                ),
              ),
            ),
          ),
      ]),
    ));
  }
}
