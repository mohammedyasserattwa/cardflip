// ignore_for_file: unnecessary_new

import 'dart:ffi';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../models/libraryModel.dart';
import '../widgets/navibar.dart';
import '../widgets/deck.dart';

class Adddeck extends StatefulWidget {
  const Adddeck({super.key});

  @override
  State<Adddeck> createState() => _AdddeckState();
}

class _AdddeckState extends State<Adddeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/Categorylaw.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Images/banners/adddeck/adddeck.png"),
                  fit: BoxFit.cover,
                ),
              ),
              width: 400,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, bottom: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "PolySans_Median",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 48,
                      ),
                    ),
                  ],
                ),
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.5))),
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
                        borderRadius: BorderRadius.all(Radius.circular(0.5))),
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
