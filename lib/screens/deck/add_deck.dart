// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, unused_import, prefer_const_constructors

//import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/helpers/loading_screen.dart';
import 'package:cardflip/models/deck_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import "package:flutter/material.dart";
import 'package:recase/recase.dart';
import '../../helpers/random_generator.dart';
// import '../models/libraryModel.dart';
import '../../widgets/navibar.dart';

class Adddeck extends ConsumerStatefulWidget {
  const Adddeck({key, required this.screens, this.deck});
  final String screens;
  final Deck? deck;
  @override
  ConsumerState<Adddeck> createState() => _AdddeckState();
}

class _AdddeckState extends ConsumerState<Adddeck> {
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final GlobalKey _nameKey = GlobalKey<FormState>();
  final GlobalKey _descriptionKey = GlobalKey<FormState>();
  final DeckModel deckModel = DeckModel();
  final List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    if (widget.screens == "edit") {
      _controllerTitle.text = widget.deck!.name;
      _controllerDescription.text = widget.deck!.description;
      _selectedTags.addAll((widget.deck!.tags).map((item) => item));
    }
    final userData = ref.watch(UserDataProvider);
    return Scaffold(
      body: FutureBuilder(
          future: deckModel.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Images/backgrounds/deckbackground.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Images/icons/arrow-left-s-line.png"),
                                        fit: BoxFit.cover),
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Text("")),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                            (widget.screens == "edit")
                                ? "Edit Deck"
                                : "Create Deck",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xBF000000),
                                fontFamily: 'PolySans_Median',
                                fontSize: 48,
                                fontWeight: FontWeight.w500)),
                      ),
                      Expanded(
                        child: ListView(children: [
                          Text(
                            "Title",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "PolySans_Median",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextField(
                              controller: _controllerTitle,
                              key: _nameKey,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.1),
                                hintText: 'Enter the deck title',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Description",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "PolySans_Median",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextField(
                              controller: _controllerDescription,
                              key: _descriptionKey,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  //<-- SEE HERE
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.1),
                                hintText: 'Enter the deck description',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Tags",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "PolySans_Median",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MultiSelectContainer(
                                textStyles: MultiSelectTextStyles(
                                    textStyle: TextStyle(
                                        fontFamily: "PolySans_Neutral",
                                        fontSize: 15,
                                        color: Color(0xff212523)),
                                    selectedTextStyle: TextStyle(
                                        fontFamily: "PolySans_Neutral",
                                        fontSize: 15,
                                        color: Color(0xff212523))),
                                itemsDecoration: MultiSelectDecorations(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.1),
                                        ]),
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.1)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    selectedDecoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffA000A4),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0xffF4B1EB),
                                    )),
                                items: [
                                  for (int i = 0;
                                      i < snapshot.data!.length;
                                      i++)
                                    MultiSelectCard(
                                      selected: _selectedTags
                                          .contains(snapshot.data![i]["id"]),
                                      value: snapshot.data![i]["id"],
                                      label: ReCase(snapshot.data![i]["name"])
                                          .titleCase,
                                    ),
                                ],
                                onChange: (allSelectedItems, selectedItem) {
                                  setState(() {
                                    _selectedTags.addAll((allSelectedItems)
                                        .map((item) => item as String)
                                        .toList());
                                  });
                                }),
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, bottom: 35),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              if (_controllerTitle.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text(
                                            "Please enter a title for your deck"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      );
                                    });
                              } else if (_controllerDescription.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text(
                                            "Please enter a description for your deck"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                //TODO: Add deck to database

                                Navigator.pop(context);
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
                ),
              );
            }
            return Center(
              child: LoadingWidget(),
            );
          }),
    );
  }
}