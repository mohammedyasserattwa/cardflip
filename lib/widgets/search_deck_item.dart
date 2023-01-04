import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/card_generator.dart';
import "package:flutter/material.dart";

class SearchDeckItem extends StatelessWidget {
  String name;
  CardGenerator randomizer = CardGenerator();
  SearchDeckItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 139,
      height: 116.67,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: AutoSizeText(
          name,
          minFontSize: 12,
          stepGranularity: 1,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "PolySans_Neutral",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff2D2D2D),
          ),
        ),
      ),
    );
  }
}
