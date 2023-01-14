import 'package:cardflip/widgets/search_people_item.dart';
import "package:flutter/material.dart";
import 'package:no_glow_scroll/no_glow_scroll.dart';

class PeopleScreen extends StatelessWidget {
  dynamic people;
  PeopleScreen({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return (people.isNotEmpty)
        ? Expanded(
            child: NoGlowScroll(
            child: ListView(
              children: [
                for (int i = 0; i < people.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SearchPeopleItem(person: people[i]),
                  )
              ],
            ),
          ))
        : Expanded(
            // height: 116.67,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "No People found",
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
