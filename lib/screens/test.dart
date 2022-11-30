import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../models/testModel.dart';
import '../data/testdata.dart';
import '../data/card_generator.dart';

class Test extends StatefulWidget {
  const Test({key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // ignore: unnecessary_new
  testModel model = new testModel(new test());
  CardGenerator cardgenerator = new CardGenerator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/Test Page.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "Images/icons/close_button.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 25,
                            height: 25,
                            child: Text(""))),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("Images/icons/more-fill.png"),
                                  fit: BoxFit.cover),
                            ),
                            width: 30,
                            height: 30,
                            child: Text(""))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: AssetImage("Images/backgrounds/Group 33.png"),
                          fit: BoxFit.cover),
                    ),
                    width: 453,
                    height: 556,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                model.q,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Images/backgrounds/Group 481722.png"),
                                      fit: BoxFit.cover),
                                ),
                                height: 50,
                                width: 150,
                                child: Center(
                                  child: Text(
                                    model.c1,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Images/backgrounds/Group 481722.png"),
                                      fit: BoxFit.cover),
                                ),
                                height: 50,
                                width: 150,
                                child: Center(
                                  child: Text(
                                    model.c2,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Images/backgrounds/Group 481722.png"),
                                      fit: BoxFit.cover),
                                ),
                                height: 50,
                                width: 150,
                                child: Center(
                                  child: Text(
                                    "${model.c3}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                        decoration: BoxDecoration(
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
                          style: TextStyle(
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
                child: AutoSizeText(
                  cardgenerator.deck,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 12,
                  stepGranularity: 1,
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
