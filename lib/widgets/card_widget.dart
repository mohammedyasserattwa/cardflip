import 'package:flip_card/flip_card.dart';
import "package:flutter/material.dart";
import 'package:cardflip/data/card.dart' as CardHandler;

class CardWidget extends StatefulWidget {
  CardWidget({
    Key? key,
    required this.image,
    required this.card,
    this.begin = 0.0,
    this.end = 0.0,
    this.empty = false,
    this.celebration = false,
    required this.updateParent,
  }) : super(key: key);
  CardWidget.emptyCard({
    super.key,
    required this.image,
    this.card,
    this.begin = 0.0,
    this.end = 0.0,
    this.empty = true,
    this.celebration = false,
    required this.updateParent,
  });
  CardWidget.celebrationCard({
    super.key,
    required this.image,
    this.card,
    this.begin = 0.0,
    this.end = 0.0,
    this.empty = false,
    this.celebration = true,
    required this.updateParent,
  });
  final String image;
  // final String term;
  // final String definition;
  CardHandler.Card? card = CardHandler.Card(term: "", definition: "");
  final double begin;
  final double end;
  final bool empty;
  final bool celebration;
  final Function updateParent;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final double _cardWidth = 343;
  final double _cardHeight = 511.97;
  IconData star = Icons.star_border;
  @override
  void initState() {
    if (widget.card != null)
      star = (widget.card!.isFavourite) ? Icons.star : Icons.star_border;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!widget.empty && !widget.celebration) {
      return TweenAnimationBuilder(
          tween: Tween<double>(begin: widget.begin, end: widget.end),
          duration: const Duration(milliseconds: 250),
          builder: (BuildContext context, double pos, __) {
            return Transform(
              transform: Matrix4.identity()..translate(pos),
              child: FlipCard(
                front: Container(
                  width: _cardWidth,
                  height: _cardHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, top: 60),
                            child: GestureDetector(
                                onTap: () {
                                  if (star == Icons.star_border) {
                                    setState(() {
                                      star = Icons.star;
                                      widget.card!.toggleFavourite();
                                    });
                                  } else {
                                    setState(() {
                                      star = Icons.star_border;
                                      widget.card!.toggleFavourite();
                                    });
                                  }
                                  widget.updateParent();
                                },
                                child: Icon(star, size: 36)),
                            // child: Container(
                            //     width: 36,
                            //     height: 36,
                            //     decoration: const BoxDecoration(
                            //       image: DecorationImage(
                            //         image: AssetImage(
                            //             "Images/icons/star-fill.png"),
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //     child: Text("")),
                          ),
                        ],
                      ),
                      Center(
                          child: Text(
                        widget.card!.getTerm,
                        textAlign: TextAlign.center,
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
                ),
                back: Container(
                  width: _cardWidth,
                  height: _cardHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.fill),
                  ),
                  child: Center(
                      child: Text(
                    widget.card!.getDefinitions,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "PolySans_Median",
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1B4F55),
                    ),
                  )),
                ),
              ),
            );
          });
    }
    if (widget.empty) {
      return Container(
        width: _cardWidth,
        height: _cardHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.image), fit: BoxFit.fill),
        ),
        child: const Text(""),
      );
    }
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(widget.image), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "You Did It!",
              style: const TextStyle(
                fontFamily: "PolySans_Median",
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: Color(0xff1B4F55),
              ),
            ),
            Text(
              "You are now ready for a test!",
              style: TextStyle(
                  fontFamily: "PolySans_Slim",
                  fontWeight: FontWeight.w300,
                  color: Color(0xff484848),
                  fontSize: 20),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xff1B4F55),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      "Start Over",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      "Test!",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
