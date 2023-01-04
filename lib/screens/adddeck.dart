// ignore_for_file: unnecessary_new

//import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import "package:flutter/material.dart";
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
// import '../models/libraryModel.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';

// main() => runApp(MaterialApp(
//       home: Adddeck(),
//     ));

class Adddeck extends StatefulWidget {
  const Adddeck({key});

  @override
  State<Adddeck> createState() => _AdddeckState();
}

class _AdddeckState extends State<Adddeck> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/deckbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                  child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "Images/icons/arrow-left-s-line.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 40,
                      height: 40,
                      child: const Text(""))),
            ),
            Text(
              "Create Deck",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 48,
              ),
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
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(40),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    hintText: 'Enter the deck title',
                  ),
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
                TextField(
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
                MultiSelectContainer(
                    itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.1),
                          ]),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(20)),
                      selectedDecoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.black, Colors.grey]),
                          border: Border.all(color: Colors.blueGrey[700]!),
                          borderRadius: BorderRadius.circular(5)),
                      disabledDecoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: [
                      MultiSelectCard(value: 'Dart', label: 'Dart'),
                      MultiSelectCard(value: 'Python', label: 'Python'),
                      MultiSelectCard(
                        value: 'JavaScript',
                        label: 'JavaScript',
                      ),
                      MultiSelectCard(value: 'Java', label: 'Java'),
                      MultiSelectCard(value: 'C#', label: 'C#'),
                      MultiSelectCard(value: 'C++', label: 'C++'),
                    ],
                    onChange: (allSelectedItems, selectedItem) {}),
              ]),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, right: 20),
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => "done",
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
