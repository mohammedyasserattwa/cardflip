import "package:flutter/material.dart";
import "../models/flashcardModel.dart";
import '../widgets/navibar.dart';

class Flashcard extends StatefulWidget {
  Flashcard({super.key});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final model = FlashcardModel();
  void _pop() {
    setState(() {
      model.pop();
    });
  }

  void _push() {
    setState(() {
      model.push();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/FlashcardBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 30, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(""),
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Images/icons/close_button.png")),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(""),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/more-three.png")),
                      ),
                    )
                  ]),
            ),
            Stack(
              children: [
                for (int i = 0, j = 2, k = 0;
                    i < model.queue;
                    i++, j--, k += 30)
                  Column(
                    children: [
                      SizedBox(
                        height: k.toDouble(),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                            image:
                                "Images/cards/flashcards/${(j == 1) ? 0 : j}.png",
                            front: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30.0, top: 60),
                                      child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "Images/icons/star-fill.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: Text("")),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 150,
                                // ),
                                Center(
                                    child: Text(
                                  model.terms[i],
                                  style: const TextStyle(
                                    fontFamily: "PolySans_Median",
                                    fontSize: 48,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1B4F55),
                                  ),
                                )),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 40.0),
                                  child: Center(
                                      child: Text(
                                    "Click to flip the card",
                                    style: TextStyle(
                                        fontFamily: "PolySans_Slim",
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xff484848),
                                        fontSize: 20),
                                  )),
                                ),
                              ],
                            ),
                            back: Center(
                                child: Text(
                              model.definitions[i],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "PolySans_Median",
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1B4F55),
                              ),
                            ))),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _push();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 50,
                        color: Color(0xff1B4F55),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pop();
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 50,
                        color: Color(0xff1B4F55),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(),
    );
  }
}

class Card extends StatefulWidget {
  const Card({
    Key? key,
    required this.front,
    required this.back,
    required this.image,
  }) : super(key: key);

  final Widget front;
  final Widget back;
  final String image;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  bool isBack = true;
  double angle = 0;
  void _flip() {
    setState(() {
      angle = (angle + 3.14159265) % (2 * 3.14159265);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: angle),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double val, __) {
            if (val >= (3.14159265 / 2)) {
              isBack = false;
            } else {
              isBack = true;
            }
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(val),
              child: (Container(
                width: 343,
                height: 511.97,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.fill),
                ),
                child: isBack
                    ? widget.front
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(3.14159265),
                        child: widget.back),
              )),
            );
          }),
    );
    //
  }
}
