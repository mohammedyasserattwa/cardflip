// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, await_only_futures

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
  List<TextEditingController> ControllerDefinitionData = [
    TextEditingController()
  ];
  List<TextEditingController> ControllerTermData = [TextEditingController()];
  List termkeys = [GlobalKey<FormState>()];
  List definitionkeys = [GlobalKey<FormState>()];
  List resultedData = [Column()];

  Future createFlashCard(
      {required TextEditingController Term,
      required TextEditingController Definition}) async {
    final docDeck =
        await FirebaseFirestore.instance.collection("deck").doc(widget.deck.id);
    final data = await docDeck.get();
    //print(widget.id);
    List gatheredList = data['flashcards'].map((e) {
      return card_data.Card.fromJson(e);
    }).toList();
    final flash = card_data.Card(
      id: data['flashcards'].length.toString(),
      term: Term.text,
      definition: Definition.text,
    );
    gatheredList.add(flash);
    final json = gatheredList.map((e) {
      return e.toJson();
    }).toList();
    final updatedData = docDeck.update({'flashcards': json});
    // final update = docDeck.update({'flashcards': card_data.Card(
    //   id: data['flashcards'].length,
    //   term: Term.text,
    //   definition: Definition.text,
    // );});
    // 'flashcards.definition': Definition.text,
    // 'flashcards.term': Term.text,
    // 'flashcards.id': data['flashcards'].length,
    // await docDeck.set(json);
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
                                    color: Color.fromARGB(42, 167, 167, 167)),
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
                                                fontFamily: 'PolySans_Median',
                                                fontSize: 24,
                                                color: Color(0xCC000000),
                                                // fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 207, right: 15, top: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  resultedData.remove(
                                                      resultedData[index]);
                                                });
                                              },
                                              child: index == 0
                                                  ? Container()
                                                  : Opacity(
                                                      opacity: 0.85,
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
                                                                  .circular(16),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "Images/icons/trash.png"),
                                                            fit: BoxFit.cover,
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
                                            color: Color.fromARGB(
                                                93, 167, 167, 167),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          height: 130,
                                          child: addflashcard_input(
                                            color: false,
                                            ControllerData:
                                                ControllerDefinitionData[index],
                                            keys: definitionkeys[index],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                resultedData.add(Column());
                                ControllerDefinitionData.add(
                                    TextEditingController());
                                ControllerTermData.add(TextEditingController());
                                termkeys.add(GlobalKey<FormState>());
                                definitionkeys.add(GlobalKey<FormState>());
                              });
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("Images/icons/add.png"),
                                      fit: BoxFit.cover),
                                ),
                                width: 40,
                                height: 40,
                                child: const Text(""))),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, bottom: 35, top: 65),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              for (int index = 0;
                                  index < ControllerDefinitionData.length;
                                  index++) {
                                if (ControllerDefinitionData[index]
                                        .text
                                        .isNotEmpty ||
                                    ControllerTermData[index].text.isNotEmpty) {
                                  createFlashCard(
                                      Definition:
                                          ControllerDefinitionData[index],
                                      Term: ControllerTermData[index]);
                                } else {
                                  print('Please enter a text into the fields');
                                }
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
                )),
              ],
            )));
  }
}
