import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/models/user_model.dart';
import 'package:cardflip/widgets/search/all_search_screen.dart';
import 'package:cardflip/widgets/search/deck_search_screen.dart';
import 'package:cardflip/widgets/search/people_search_screen.dart';
import 'package:cardflip/widgets/search/tag_search_screen.dart';
import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

class SearchResult extends StatefulWidget {
  final String query;
  const SearchResult({super.key, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  DeckModel deckModel = DeckModel();
  UserModel userModel = UserModel();
  final List<bool> _currentPage = [true, false, false, false];
  late Widget _currentState;
  _resetPages() {
    for (int i = 0; i < _currentPage.length; i++) {
      _currentPage[i] = false;
    }
  }

  Future<Map<String, dynamic>> getData() async {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final decks = snapshot.data!["decks"];
            final tags = snapshot.data!["tags"];
            final people = snapshot.data!["people"];
            final allScreen =
                AllScreen(decks: decks, tags: tags, people: people, onTap: [
              () {
                setState(() {
                  _resetPages();
                  _currentPage[1] = true;
                  _currentState = DeckSearchScreen(
                    decks: decks,
                  );
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
            if (counter++ == 0) {
              _currentState = allScreen;
            }

            return Column(
              children: [
                SizedBox(
                  height: 60,
                  child: NoGlowScroll(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!_currentPage[0]) {
                              setState(() {
                                _resetPages();
                                _currentPage[0] = true;
                                _currentState = allScreen;
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
                                  child: Center(
                                      child: Text("All", style: _textStyle)),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!_currentPage[1]) {
                              setState(() {
                                _resetPages();
                                _currentPage[1] = true;
                                _currentState = DeckSearchScreen(
                                  decks: decks,
                                );
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
                  ),
                ),
                _currentState
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}
