// ignore_for_file: unnecessary_new

import 'dart:ffi';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/dummy_data.dart';
import '../data/card_generator.dart';
import '../models/libraryModel.dart';



class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  // LibraryModel model = new LibraryModel(new DummyData());
  CardGenerator cardgenerator = new CardGenerator();

  @override
  Widget build(BuildContext context) {
    
        return Container(
          height: 1000,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Images/backgrounds/librarypage.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Images/banners/librarypage/${cardgenerator.librarycolor}.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 400,
                height: 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 5.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                  onTap: () {},
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "Images/icons/more-fill.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: const Text(""))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Library",
                            textAlign: TextAlign.end,
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 7),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "Images/icons/allsquare.png"),
                                    fit: BoxFit.cover),
                              ),
                              width: 48,
                              height: 48,
                              child: const Center(
                                  child: Text(
                                "All",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "PolySans",
                                ),
                              )))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 7),
                    child: Text(
                      "Created \nby You",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "PolySans_Neutral",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 7),
                    child: Text(
                      "Created by \nOthers",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "PolySans_Neutral",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 7),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("Images/icons/filter.png"),
                                    fit: BoxFit.cover),
                              ),
                              width: 48,
                              height: 48,
                              child: Text(""))),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: NoGlowScroll(
                  child: ListView(
                    children: new List.generate(
                        6,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom:21.0,right:21,left:21),
                          child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Deck(
                                      cardgenerator: cardgenerator,
                                      width: 163.13,
                                      height: 158.67,
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                  Deck(
                                      cardgenerator: cardgenerator,
                                      width: 163.13,
                                      height: 158.67,
                                      path:
                                          "Images/cards/librarypage/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                                ],
                              ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}

class Deck extends StatelessWidget {
  const Deck({
    Key? key,
    required this.cardgenerator,
    required this.height,
    required this.width,
    required this.path,
  }) : super(key: key);

  final CardGenerator cardgenerator;
  final double height;
  final double width;
  final String path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        ),
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/icons/star.png"),
                              fit: BoxFit.cover),
                        ),
                        width: 15,
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${cardgenerator.rating}",
                          style: const TextStyle(
                            fontFamily: "PolySans_Neutral.ttf",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff2D2D2D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/more.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 21,
                      height: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Flexible(
                child: AutoSizeText(
                  cardgenerator.deck,
                  maxLines: 3,
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
}
