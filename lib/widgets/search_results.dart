import 'package:cardflip/data/deck.dart';
import 'package:cardflip/main.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:cardflip/widgets/search_deck_item.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:recase/recase.dart';

class SearchResult extends StatefulWidget {
  String query;
  SearchResult({super.key, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
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
      "tags": await deckModel.getData(),
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
              _currentState = AllScreen(decks, tags, people);
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
                            _currentState = AllScreen(decks, tags, people);
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
                            _currentState = DeckScreen(decks);
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

  Widget AllScreen(dynamic decks, dynamic tags, dynamic people) {
    return Column(children: [
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
              onTap: (() {
                setState(() {
                  _resetPages();
                  _currentPage[1] = true;
                  _currentState = DeckScreen(decks);
                });
              }),
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
      SizedBox(
        height: 116.67,
        child: NoGlowScroll(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: decks.length > 3 ? 3 : decks.length,
            itemBuilder: (context, index) {
              return SearchDeckItem(name: decks[index]["name"]);
            },
          ),
        ),
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
              onTap: (() {
                setState(() {
                  _resetPages();
                  _currentPage[2] = true;
                  _currentState = TagScreen(tags: tags);
                });
              }),
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
      NoGlowScroll(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < (tags.length < 12 ? tags.length : 12);
                    i += 4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = i;
                          j <= ((tags.length > i + 3) ? i + 3 : i);
                          j++)
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 175, 175, 175),
                                    width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0x8FDADADA),
                              ),
                              child: Text(ReCase(tags[j]).titleCase)),
                        ),
                    ],
                  )
              ]),
        ),
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
              onTap: (() {
                setState(() {
                  _resetPages();
                  _currentPage[3] = true;
                  // _currentState = PeopleScreen(people: tags);
                });
              }),
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
      NoGlowScroll(
          child: SingleChildScrollView(
        child: Column(children: [
          for (int index = 0; index < people.length; index++)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                    "Images/avatars/${people[index]["profileIcon"]}.svg",
                    height: 40,
                    width: 40),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  people[index]["fname"],
                  style: const TextStyle(
                    fontFamily: "PolySans_Median",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff212523),
                  ),
                )
              ],
            ),
        ]),
      ))
    ]);
  }

  Widget DeckScreen(dynamic decks) => Column(
        children: [
          for (int i = 0; i < decks.length; i += 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: (decks.length < i + 1)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  SearchDeckItem(
                    name: decks[i]["name"],
                  ),
                  if (decks.length < i + 1)
                    SearchDeckItem(
                      name: decks[i + 1]["name"],
                    ),
                ],
              ),
            )
        ],
      );
}

class TagScreen extends StatefulWidget {
  final dynamic tags;

  TagScreen({super.key, required this.tags});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List<Deck> _resultDecks = [];
  String _chosenTag = "";
  List<bool> _tagActive = [];
  final BoxDecoration _inactiveTagDecoration = BoxDecoration(
    border:
        Border.all(color: const Color.fromARGB(255, 175, 175, 175), width: 1),
    borderRadius: BorderRadius.circular(16),
    color: const Color(0x8FDADADA),
  );
  final BoxDecoration _activeTagDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xffA000A4), width: 1),
    borderRadius: BorderRadius.circular(16),
    color: const Color(0xffF4B1EB),
  );
  @override
  void initState() {
    _tagActive = List.filled(widget.tags.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NoGlowScroll(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0;
                      i < (widget.tags.length < 12 ? widget.tags.length : 12);
                      i += 4)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i;
                            j <= ((widget.tags.length > i + 3) ? i + 3 : i);
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
                                    _resultDecks = DeckModel().deckByTagID("1");
                                    _chosenTag = widget.tags[j];
                                  } else {
                                    _resultDecks = [];
                                    _chosenTag = "";
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
                                    child:
                                        Text(ReCase(widget.tags[j]).titleCase,
                                            style: const TextStyle(
                                              fontFamily: "PolySans_Neutral",
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
          padding: const EdgeInsets.only(right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "View All Tags",
                style: TextStyle(
                  fontFamily: "PolySans_Regular",
                  fontSize: 16,
                  color: Color(0xff212523),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
              )
            ],
          ),
        ),
        if (_resultDecks.isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: const Center(
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
        else
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Showing the results of the tag: ${ReCase(_chosenTag).titleCase}",
                    style: const TextStyle(
                      fontFamily: "PolySans_Neutral",
                      fontSize: 20,
                      color: Color(0xff212523),
                    ),
                  ),
                  for (int i = 0; i < _resultDecks.length; i += 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: (_resultDecks.length > i + 1)
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          SearchDeckItem(
                            name: _resultDecks[i].name,
                          ),
                          if (_resultDecks.length > i + 1)
                            SearchDeckItem(
                              name: _resultDecks[i + 1].name,
                            ),
                        ],
                      ),
                    )
                ]),
          ),
      ],
    );
  }
}
