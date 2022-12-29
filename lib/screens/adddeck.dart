// ignore_for_file: unnecessary_new

import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
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
    final height = 128.67;
    final width = 133.67;
    return Scaffold(
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/deckbackground.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
