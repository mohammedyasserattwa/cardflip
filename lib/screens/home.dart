// ignore_for_file: unnecessary_new

import 'dart:ffi';
import 'dart:io';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/homeModel.dart';
import '../data/dummy_data.dart';
import '../data/card_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeModel model = new HomeModel(new DummyData());
  CardGenerator cardgenerator = new CardGenerator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Images/backgrounds/homepage.png"),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 45, 0, 0),
            child: Stack(
              children: [
                Container(
                  child: Text(
                    "Explore",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "PolySans_Median",
                      color: Color(0xff514F55),
                      fontSize: 36,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("Images/icons/search.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 48,
                            height: 48,
                            child: Text(""))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 14, 0, 0),
            child: Text(
              "Welcome back, ${model.fname}",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
            child: Text(
              "Pick up where you left off",
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 21,
                color: Color(0xff212523),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 2, 0),
            child: SizedBox(
              height: 116.67,
              child: NoGlowScroll(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Deck(cardgenerator: cardgenerator),
                    SizedBox(width: 13),
                    Deck(cardgenerator: cardgenerator),
                    SizedBox(width: 13),
                    Deck(cardgenerator: cardgenerator),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
            child: Text("Based on what you like..",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 21,
                    color: Color(0xff212523))),
          )
        ],
      ),
    );
  }
}

class Deck extends StatelessWidget {
  const Deck({
    Key? key,
    required this.cardgenerator,
  }) : super(key: key);

  final CardGenerator cardgenerator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
              fit: BoxFit.cover),
        ),
        width: 139,
        height: 116.67,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/icons/star.png"),
                          fit: BoxFit.cover),
                    ),
                    width: 15,
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "${cardgenerator.rating}",
                      style: TextStyle(
                        fontFamily: "PolySans_Neutral.ttf",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff2D2D2D),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
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
              SizedBox(height: 15),
              Flexible(
                child: Text(
                  cardgenerator.deck,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Poppins-SemiBold",
                    color: Color(0xff131414).withOpacity(0.6),
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
