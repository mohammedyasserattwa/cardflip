// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, await_only_futures

import 'package:cardflip/helpers/loading_screen.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:cardflip/widgets/flashcards/add_flashcards_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:cardflip/data/card.dart' as card_data;

import '../../data/deck.dart';

class AddFlashcards extends StatefulWidget {
  const AddFlashcards({super.key, required this.deck});
  final Deck deck;

  @override
  State<AddFlashcards> createState() => _AddFlashcardsState();
}

class _AddFlashcardsState extends State<AddFlashcards> {
  List<TextEditingController> ControllerDefinitionData = [];
  List<TextEditingController> ControllerTermData = [];
  List termkeys = [];
  List definitionkeys = [];
  List resultedData = [];

  @override
  void initState() {
    if (widget.deck.cards.isEmpty) {
      ControllerDefinitionData = [TextEditingController()];
      ControllerTermData = [TextEditingController()];
      termkeys = [GlobalKey<FormState>()];
      definitionkeys = [GlobalKey<FormState>()];
      resultedData = [Column()];
    }
    for (int index = 0; index < widget.deck.cards.length; index++) {
      ControllerDefinitionData.add(TextEditingController());
      ControllerDefinitionData[index].text =
          widget.deck.cards[index].definition;
      ControllerTermData.add(TextEditingController());
      ControllerTermData[index].text = widget.deck.cards[index].term;
      termkeys.add(GlobalKey<FormState>());
      definitionkeys.add(GlobalKey<FormState>());
      resultedData.add(Column());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/backgrounds/homepage.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 15),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "Images/icons/arrow-left-s-line.png"),
                                fit: BoxFit.cover),
                          ),
                          width: 45,
                          height: 45,
                          child: const Text(""))),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('Add Flashcards',
                      style: TextStyle(
                          color: Color(0xBF000000),
                          fontFamily: 'PolySans_Median',
                          fontSize: 42,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(
                    flex: 1,
                    child: NoGlowScroll(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              for (int index = 0;
                                  index < resultedData.length;
                                  index++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, bottom: 25),
                                  child: Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            Color.fromARGB(42, 167, 167, 167)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25, top: 20),
                                                child: Text(
                                                  'Term',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PolySans_Median',
                                                    fontSize: 24,
                                                    color: Color(0xCC000000),
                                                    // fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 207,
                                                    right: 15,
                                                    top: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      resultedData.remove(
                                                          resultedData[index]);
                                                      ControllerDefinitionData
                                                          .remove(
                                                              ControllerDefinitionData[
                                                                  index]);
                                                      ControllerTermData.remove(
                                                          ControllerTermData[
                                                              index]);
                                                      termkeys.remove(
                                                          termkeys[index]);
                                                      definitionkeys.remove(
                                                          definitionkeys[
                                                              index]);
                                                    });
                                                  },
                                                  child: index == 0
                                                      ? Container()
                                                      : Opacity(
                                                          opacity: 0.758,
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15,
                                                                    top: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    "Images/icons/trash.png"),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 12.0, right: 12),
                                            child: addflashcard_input(
                                                color: true,
                                                ControllerData:
                                                    ControllerTermData[index],
                                                keys: termkeys[index]),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Text(
                                              'Definition',
                                              style: TextStyle(
                                                fontFamily: 'PolySans_Median',
                                                fontSize: 24,
                                                color: Color(0xCC000000),
                                                // fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 17, right: 17, top: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              height: 130,
                                              child: addflashcard_input(
                                                color: false,
                                                ControllerData:
                                                    ControllerDefinitionData[
                                                        index],
                                                keys: definitionkeys[index],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                    height: 85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    resultedData.add(Column());
                                    ControllerDefinitionData.add(
                                        TextEditingController());
                                    ControllerTermData.add(
                                        TextEditingController());
                                    termkeys.add(GlobalKey<FormState>());
                                    definitionkeys.add(GlobalKey<FormState>());
                                  });
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "Images/icons/add.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: const Text(""))),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  List<Map<String, String>> flashcards = [];
                                  bool error = false;
                                  for (int index = 0;
                                      index < ControllerDefinitionData.length;
                                      index++) {
                                    if (ControllerDefinitionData[index]
                                            .text
                                            .isNotEmpty ||
                                        ControllerTermData[index]
                                            .text
                                            .isNotEmpty) {
                                      flashcards.add({
                                        'id': (index + 1).toString(),
                                        'term': ControllerTermData[index].text,
                                        'definition':
                                            ControllerDefinitionData[index].text
                                      });
                                    } else {
                                      error = true;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: Duration(seconds: 3),
                                              content: Text(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins"),
                                                  'Please fill all the fields.')));
                                    }
                                  }
                                  if (error == false) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            Center(child: LoadingWidget()));
                                    DeckModel()
                                        .addFlashcards(
                                            flashcards, widget.deck.id)
                                        .then((value) {
                                      widget.deck.cards = [];
                                      widget.deck.setFlashcards(flashcards);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, "/deck",
                                          arguments: {"deck": widget.deck});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: Duration(seconds: 3),
                                              content: Text(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Poppins"),
                                                  'Flashcards updated successfully.')));
                                    });
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.withOpacity(0.30)),
                                    width: 85,
                                    height: 40,
                                    child: const Text("Done",
                                        style: TextStyle(
                                            color: Color(0xFF191C32),
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)))),
                          ),
                        ],
                      ),
                    ))
              ],
            )));
  }
}
