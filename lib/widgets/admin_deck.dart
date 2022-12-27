import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter/material.dart";
import '../data/Repositories/user_decks.dart';
import '../data/card_generator.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/deckModel.dart';
import '../data/deck.dart' as DeckUI;

class AdminDeck extends StatelessWidget {
   AdminDeck({
    Key? key,
    required this.height,
    required this.width,
    required this.path,
    required this.min,
    required this.onTap,
    this.id = "1",
  }) : super(key: key);

  final Function() onTap;
  final double height;
  final double width;
  final String path;
  final int min;
  final String id;

  final DeckModel model = DeckModel();

  @override
  Widget build(BuildContext context) {
    DeckUI.Deck deck = model.deckByID(id);
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/icons/trash.png"), //TODO: Trash icon
                            fit: BoxFit.cover),
                      ),
                      width: 21.07,
                      height: 22.5,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 15),
              Flexible(
                child: AutoSizeText(
                  deck.deckName,
                  maxLines: min,
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
