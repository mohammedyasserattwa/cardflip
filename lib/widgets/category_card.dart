import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/card_generator.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

import '../data/category.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({super.key, required this.category});
  final Category category;
  CardGenerator cardgenerator = CardGenerator();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/category", arguments: {
          "category": category,
        });
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "Images/cards/homepage/1_3/${cardgenerator.getcolor}/${cardgenerator.getshape}.png"),
                fit: BoxFit.cover)),
        width: 139,
        height: 116.67,
        child: Center(
          child: AutoSizeText(
            ReCase(category.categoryName).titleCase,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            minFontSize: 12,
            stepGranularity: 1,
            style: TextStyle(
              fontFamily: "Poppins-SemiBold",
              color: const Color(0xff131414).withOpacity(0.6),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
