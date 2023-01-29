import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import "package:flutter/material.dart";
import 'package:cardflip/data/card.dart' as card_handler;
import 'package:recase/recase.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:cardflip/data/deck.dart';

class CardWidget extends StatefulWidget {
  CardWidget(
      {Key? key,
      required this.image,
      required this.card,
      this.begin = 0.0,
      this.end = 0.0,
      this.empty = false,
      this.celebration = false,
      this.width = 343,
      this.height = 511.97,
      required this.updateParent,
      this.star = Icons.star_border})
      : super(key: key);
  CardWidget.emptyCard(
      {super.key,
      required this.image,
      this.card,
      this.begin = 0.0,
      this.end = 0.0,
      this.empty = true,
      this.celebration = false,
      this.width = 343,
      this.height = 511.97,
      required this.updateParent,
      this.star = Icons.star_border});
  CardWidget.celebrationCard({
    super.key,
    required this.image,
    this.card,
    this.begin = 0.0,
    this.end = 0.0,
    this.empty = false,
    this.celebration = true,
    this.width = 343,
    this.height = 511.97,
    required this.updateParent,
    this.star = Icons.star_border,
    required this.startOver,
    required this.deck,
  });
  Deck? deck;
  final String image;
  // final String term;
  // final String definition;
  card_handler.Card? card =
      card_handler.Card(term: "", definition: "", id: '0');
  final double begin;
  final double end;
  final bool empty;
  final bool celebration;
  final double width;
  final double height;
  final Function updateParent;
  final IconData star;
  Function? startOver;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late IconData star = widget.star;
  TextToSpeech tts = TextToSpeech();
  @override
  void initState() {
    double volume = 1.0;
    tts.setVolume(volume);
    double rate = 1.0;
    tts.setRate(rate);
    double pitch = 1.0;
    tts.setPitch(pitch);
    String language = 'en-US';
    tts.setLanguage(language);
    if (widget.card != null) {
      star = widget.star;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = widget.width;
    final double cardHeight = widget.height;
    if (widget.card != null) {
      if (widget.card!.isFavourite && star == Icons.star_border) {
        setState(() {
          star = Icons.star;
        });
      } else if (!widget.card!.isFavourite && star == Icons.star) {
        setState(() {
          star = Icons.star_border;
        });
      }
    }
    if (!widget.empty && !widget.celebration) {
      return TweenAnimationBuilder(
          tween: Tween<double>(begin: widget.begin, end: widget.end),
          duration: const Duration(milliseconds: 250),
          builder: (BuildContext context, double pos, __) {
            return Transform(
              transform: Matrix4.identity()..translate(pos),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  width: (MediaQuery.of(context).size.height > 652)
                      ? cardWidth
                      : cardWidth - 50,
                  height: (MediaQuery.of(context).size.height > 751)
                      ? cardHeight
                      : (MediaQuery.of(context).size.height > 652)
                          ? cardHeight - 100
                          : cardHeight - 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 60),
                            child: GestureDetector(
                                onTap: () {
                                  tts.speak(widget.card!.term);
                                },
                                child: const Icon(Icons.volume_up, size: 36)),
                          ),
                          // Text(widget.card!.isFavourite.toString()),
                          // Text((star == Icons.star) ? "Star" : "Border"),
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
                          ),
                        ],
                      ),
                      Center(
                          child: AutoSizeText(
                        ReCase(widget.card!.getTerm).titleCase,
                        maxLines: 4,
                        minFontSize: 35,
                        maxFontSize: 48,
                        stepGranularity: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "PolySans_Median",
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
                  width: (MediaQuery.of(context).size.height > 652)
                      ? cardWidth
                      : cardWidth - 50,
                  height: (MediaQuery.of(context).size.height > 751)
                      ? cardHeight
                      : (MediaQuery.of(context).size.height > 652)
                          ? cardHeight - 100
                          : cardHeight - 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 60),
                            child: GestureDetector(
                                onTap: () {
                                  tts.speak(widget.card!.getDefinitions);
                                },
                                child: Icon(Icons.volume_up, size: 36)),
                          ),
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
                          ),
                        ],
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AutoSizeText(
                          widget.card!.getDefinitions,
                          minFontSize: 22,
                          maxFontSize: 25,
                          maxLines: 7,
                          stepGranularity: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "PolySans_Median",
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1B4F55),
                          ),
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
              ),
            );
          });
    }
    if (widget.empty) {
      return Container(
        width: (MediaQuery.of(context).size.height > 652)
            ? cardWidth
            : cardWidth - 50,
        height: (MediaQuery.of(context).size.height > 751)
            ? cardHeight
            : (MediaQuery.of(context).size.height > 652)
                ? cardHeight - 100
                : cardHeight - 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.image), fit: BoxFit.fill),
        ),
        child: const Text(""),
      );
    }
    return Container(
      width: (MediaQuery.of(context).size.height > 652)
          ? cardWidth
          : cardWidth - 50,
      height: (MediaQuery.of(context).size.height > 751)
          ? cardHeight
          : (MediaQuery.of(context).size.height > 652)
              ? cardHeight - 100
              : cardHeight - 200,
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
            const Text(
              "You did it!",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontSize: 48,
                fontWeight: FontWeight.w600,
                color: Color(0xff1B4F55),
              ),
            ),
            Center(
              child: const Text(
                "You are now ready for a test!",
                style: TextStyle(
                    fontFamily: "PolySans_Slim",
                    fontWeight: FontWeight.w300,
                    color: Color(0xff484848),
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {
                widget.startOver!();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xff1B4F55),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Start over",
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
                onTap: () {
                  if (widget.deck!.cards.length <= 3) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 3),
                            content: Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: "Poppins"),
                                'You can start a test once you have created at least 3 cards!')))
                        .closed
                        .then((value) =>
                            ScaffoldMessenger.of(context).clearSnackBars());
                    return;
                  } else {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/test',
                        arguments: {"deck": widget.deck});
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromARGB(255, 216, 77, 77),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      "Take the test",
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
