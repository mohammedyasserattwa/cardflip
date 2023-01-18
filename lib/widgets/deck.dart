import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import '../data/Repositories/user_decks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/deckModel.dart';
import '../data/deck.dart' as DeckUI;

class Deck extends ConsumerWidget {
  Deck({
    Key? key,
    required this.height,
    required this.width,
    required this.path,
    required this.min,
    required this.onTap,
    this.deck,
    this.id = "1",
  }) : super(key: key);

  final Function() onTap;
  final double height;
  final double width;
  final DeckUI.Deck? deck;
  final String path;
  final int min;
  final String id;
  final DeckModel model = DeckModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratings = ref.watch(RatingProvider);

    // DeckUI.Deck deck = model.deckByID(id);

    return GestureDetector(
      onTap: onTap,
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
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset(
                            "Images/icons/svg/${ratings.contains(deck!.id) ? "like-fill" : "like-line"}.svg",
                            height: 47.4,
                            width: 47.4),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          deck!.deckRating,
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
                  deck!.deckName,
                  maxLines: 1,
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
