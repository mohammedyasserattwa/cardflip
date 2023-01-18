import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/adminModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/Repositories/user_decks.dart';
import '../data/card_generator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/deckModel.dart';
import '../data/deck.dart' as DeckUI;

class AdminDeck extends StatefulWidget {
  AdminDeck({
    Key? key,
    required this.height,
    required this.width,
    required this.path,
    required this.min,
    required this.onTap,
    required this.deck,
  }) : super(key: key);

  final Function() onTap;
  final double height;
  final double width;
  final String path;
  final int min;
  final Future<Deck> deck;

  @override
  State<AdminDeck> createState() => _AdminDeckState();
}

class _AdminDeckState extends State<AdminDeck> {
  final DeckModel model = DeckModel();
  AdminModel adminModel = AdminModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.deck,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.stackTrace.toString()));
          }
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.path), fit: BoxFit.cover),
                ),
                width: widget.width,
                height: widget.height,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Container(
                                        width: 300,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Images/backgrounds/homepage.png"),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              "Confirm Deletion!",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Median",
                                                color: Color.fromARGB(
                                                    239, 105, 0, 0),
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "Are you sure you want to delete this deck?",
                                              style: TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                color: Color.fromARGB(
                                                    239, 105, 0, 0),
                                                fontSize: 15,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ButtonBar(children: [
                                                  TextButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      adminModel.deleteDeck(
                                                          snapshot.data!.id);
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: Container(
                                                              width: 300,
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "Images/backgrounds/homepage.png"),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    "Banned!",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "PolySans_Median",
                                                                      color: Color
                                                                          .fromARGB(
                                                                              239,
                                                                              105,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Deck Banned Successfully",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "PolySans_Slim",
                                                                      color: Color
                                                                          .fromARGB(
                                                                              239,
                                                                              105,
                                                                              0,
                                                                              0),
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      TextButton(
                                                                        child: Text(
                                                                            "Close"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                              setState(() {});
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "Images/icons/trash.png"), //TODO: Trash icon
                                    fit: BoxFit.cover),
                              ),
                              width: 21.07,
                              height: 22.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Flexible(
                        child: AutoSizeText(
                          snapshot.data!.name,
                          maxLines: widget.min,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 12,
                          stepGranularity: 1,
                          style: TextStyle(
                            fontFamily: "Poppins-SemiBold",
                            color: const Color(0xff131414).withOpacity(0.6),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
