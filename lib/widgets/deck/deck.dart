import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import '../../data/Repositories/user_decks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../models/deck_model.dart';
import '../../data/deck.dart' as deck_widget;

class Deck extends ConsumerWidget {
  Deck({
    Key? key,
    required this.height,
    required this.width,
    required this.path,
    required this.min,
    required this.onTap,
    this.deck,
  }) : super(key: key);

  final Function() onTap;
  final double height;
  final double width;
  final deck_widget.Deck? deck;
  final String path;
  final int min;
  final DeckModel model = DeckModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratings = ref.watch(RatingProvider);

    // deck_widget.Deck deck = model.deckByID(id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/deck", arguments: {"deck": deck});
      },
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: Text(
                  //     deck!.deckRating,
                  //     style: const TextStyle(
                  //       fontFamily: "PolySans_Neutral.ttf",
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Color(0xff2D2D2D),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 20,
                  //   height: 20,
                  //   child: SvgPicture.asset(
                  //     "Images/icons/svg/like-fill.svg",
                  //     // "Images/icons/svg/${ratings.contains(deck!.id) ? "like-fill" : "like-line"}.svg",
                  //     height: 47.4,
                  //     width: 47.4,
                  //     color: const Color(0xff2D2D2D),
                  //   ),
                  // ),
                ],
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    deck!.deckName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 14,
                    stepGranularity: 7,
                    style: TextStyle(
                      fontFamily: "Poppins-SemiBold",
                      color: const Color(0xff131414).withOpacity(0.6),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
