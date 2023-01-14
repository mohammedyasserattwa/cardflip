import 'package:cardflip/widgets/search_deck_item.dart';
import "package:flutter/material.dart";

class DeckSearchScreen extends StatelessWidget {
  final dynamic decks;
  DeckSearchScreen({super.key, required this.decks});

  @override
  Widget build(BuildContext context) {
    return (decks.isNotEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < decks.length; i += 2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: (decks.length < i + 1)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      SearchDeckItem(
                        name: decks[i]["name"],
                      ),
                      if (decks.length < i + 1)
                        SearchDeckItem(
                          name: decks[i + 1]["name"],
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
