import 'package:cardflip/helpers/random_generator.dart';
import 'package:cardflip/widgets/deck/deck.dart';
import 'package:cardflip/widgets/search/search_deck_item.dart';
import "package:flutter/material.dart";

class DeckSearchScreen extends StatelessWidget {
  final dynamic decks;
  DeckSearchScreen({super.key, required this.decks});
  RandomGenerator randomizer = RandomGenerator();

  @override
  Widget build(BuildContext context) {
    return (decks.isNotEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < decks.length; i += 2)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: (decks.length > i + 1)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      Deck(
                        height: 116.67,
                        width: 139,
                        deck: decks[i],
                        path:
                            "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png",
                        min: 3,
                        onTap: () {
                          Navigator.pushNamed(context, "/deck",
                              arguments: {"deck": decks[i + 1]});
                        },
                      ),
                      if (decks.length > i + 1)
                        Deck(
                          height: 116.67,
                          width: 139,
                          deck: decks[i + 1],
                          path:
                              "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png",
                          min: 3,
                          onTap: () {
                            Navigator.pushNamed(context, "/deck",
                                arguments: {"deck": decks[i + 1]});
                          },
                        ),
                    ],
                  ),
                )
            ],
          )
        : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "No Decks found",
                  style: TextStyle(
                    fontFamily: "PolySans_Median",
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Color.fromARGB(255, 73, 75, 74),
                  ),
                ),
              ],
            ),
          );
  }
}
