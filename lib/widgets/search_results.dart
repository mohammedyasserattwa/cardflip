import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/widgets/search_deck_item.dart';
import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

class SearchResult extends StatefulWidget {
  String query;
  SearchResult({super.key, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  DeckModel deckModel = DeckModel();
  List<bool> _currentPage = [true, false, false, false];
  late Widget _currentState;
  _resetPages() {
    for (int i = 0; i < _currentPage.length; i++) {
      _currentPage[i] = false;
    }
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
        future: deckModel.decksByQuery(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (counter++ == 0) {
              _currentState = AllScreen(snapshot);
            }
            return Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _resetPages();
                            _currentPage[0] = true;
                            _currentState = AllScreen(snapshot);
                          });
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
                          setState(() {
                            _resetPages();
                            _currentPage[1] = true;
                            _currentState = DeckScreen(snapshot);
                          });
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
                          setState(() {
                            _resetPages();
                            _currentPage[2] = true;
                          });
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
                          setState(() {
                            _resetPages();
                            _currentPage[3] = true;
                          });
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
                  Expanded(child: _currentState)
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget AllScreen(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    }

    if (snapshot.hasData) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    _currentState = DeckScreen(snapshot);
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
        Expanded(
            child: NoGlowScroll(
                child: ListView(
          children: [
            SizedBox(
              height: 116.67,
              child: NoGlowScroll(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      snapshot.data!.length > 3 ? 3 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return SearchDeckItem(name: snapshot.data![index]["name"]);
                  },
                ),
              ),
            ),
          ],
        )))
      ]);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget DeckScreen(snapshot) => ListView(
        children: [
          for (int i = 0; i < snapshot.data!.length; i += 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: (snapshot.data!.length < i + 1)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  SearchDeckItem(
                    name: snapshot.data![i]["name"],
                  ),
                  if (snapshot.data!.length < i + 1)
                    SearchDeckItem(
                      name: snapshot.data![i + 1]["name"],
                    ),
                ],
              ),
            )
        ],
      );
}
