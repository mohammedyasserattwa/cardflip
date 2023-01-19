import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/flashcard_state.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import '../../data/deck.dart' as deck_data;

class Card extends ConsumerWidget {
  String cardName;
  String path;
  String index;
  String id;
  deck_data.Deck deck;
  Card(
      {super.key,
      required this.deck,
      required this.cardName,
      required this.path,
      required this.index,
      required this.id});
  //Images/cards/homepage/1_3/0-15/0-15.png
  // final CardGenerator _cardGen;

  final textStyle = TextStyle(
    fontFamily: "Poppins-SemiBold",
    color: const Color(0xff131414).withOpacity(0.6),
    fontSize: 16,
  );
  final width = 163.13;
  final height = 158.67;

  _responsive(BuildContext context) {
    if (MediaQuery.of(context).size.width < 299) {
      return {"height": 113.67, "width": 118.67, "fontSize": 16};
    } else if (MediaQuery.of(context).size.width < 340) {
      return {"height": 128.67, "width": 133.67, "fontSize": 20};
    } else if (MediaQuery.of(context).size.width < 358) {
      return {"height": 148.67, "width": 153.67, "fontSize": 20};
    } else {
      return {"height": 158.67, "width": 163.67, "fontSize": 20};
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic resposiveSize = _responsive(context);
    final image = BoxDecoration(
      image: DecorationImage(image: AssetImage(path)),
    );
    return GestureDetector(
        onTap: () {
          ref.read(FlashcardStateProvider.notifier).state = index;
          Navigator.pushNamed(context, '/flashcards',
              arguments: {"deck": deck});
        },
        child: Container(
            decoration: image,
            width: resposiveSize["width"],
            height: resposiveSize["height"],
            child: Center(
              child: AutoSizeText(
                cardName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                minFontSize: double.parse(resposiveSize["fontSize"].toString()),
                stepGranularity: 1,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            )));
  }
}
