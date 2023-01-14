import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/widgets/search_deck_item.dart';
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
  List<Deck> _resultDecks = [];
  String _chosenTag = "";
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
                                            _resultDecks =
                                                DeckModel().deckByTagID("1");
                                            _chosenTag = widget.tags[j].name;
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
                          style: TextStyle(
                            fontFamily: "PolySans_Regular",
                            fontSize: 16,
                            color: Color(0xff212523),
                          ),
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
                else
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          )
        : Expanded(
            // height: 116.67,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
}
