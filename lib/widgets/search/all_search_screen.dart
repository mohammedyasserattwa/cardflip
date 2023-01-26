import 'package:cardflip/data/deck.dart';
import 'package:cardflip/helpers/random_generator.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import 'package:cardflip/widgets/deck/deck.dart' as deck_ui;
import 'package:recase/recase.dart';

class AllScreen extends ConsumerWidget {
  final List<Deck> decks;
  final dynamic tags;
  final dynamic people;
  final RandomGenerator randomizer = RandomGenerator();
  final List<Function> onTap;
  AllScreen(
      {super.key,
      required this.tags,
      required this.people,
      required this.onTap,
      required this.decks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: NoGlowScroll(
            child: ListView(padding: EdgeInsets.zero, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Decks",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xff212523),
              ),
            ),
            GestureDetector(
              onTap: (() {
                onTap[0]();
              }),
              child: const Text(
                "View All",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: 16,
                  color: Color(0xff212523),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
          height: 116.67,
          child: (decks.isEmpty)
              ? const SizedBox(
                  height: 116.67,
                  child: Center(
                    child: Text(
                      "No decks found",
                      style: TextStyle(
                        fontFamily: "PolySans_Median",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromARGB(255, 73, 75, 74),
                      ),
                    ),
                  ),
                )
              : NoGlowScroll(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: decks.length > 3 ? 3 : decks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: deck_ui.Deck(
                            height: 116.67,
                            width: 139,
                            deck: decks[index],
                            path:
                                "Images/cards/homepage/1_3/${randomizer.getcolor}/${randomizer.getshape}.png",
                            min: 3,
                            onTap: () {
                              Navigator.pushNamed(context, "/deck",
                                  arguments: {"deck": decks[index]});
                            },
                          ),
                        );
                      }))),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Tags",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xff212523),
              ),
            ),
            GestureDetector(
              onTap: (() {
                onTap[1]();
              }),
              child: const Text(
                "View All",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: 16,
                  color: Color(0xff212523),
                ),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      if (tags.isNotEmpty)
        NoGlowScroll(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("${(tags.length)}"),
                  for (int i = 0;
                      i < (tags.length > 12 ? 12 : tags.length);
                      i += 4)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i; //0 -> 3<3
                            j < ((tags.length > i + 4) ? i + 4 : tags.length);
                            j++)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 175, 175, 175),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0x8FDADADA),
                                ),
                                child: Text(ReCase(tags[j].name).titleCase)),
                          ),
                      ],
                    )
                ]),
          ),
        )
      else
        const SizedBox(
          height: 116.67,
          child: Center(
            child: Text(
              "No Tags found",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color.fromARGB(255, 73, 75, 74),
              ),
            ),
          ),
        ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "People",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xff212523),
              ),
            ),
            GestureDetector(
              onTap: (() {
                onTap[2]();
              }),
              child: const Text(
                "View All",
                style: TextStyle(
                  fontFamily: "Poppins-Regular",
                  fontSize: 16,
                  color: Color(0xff212523),
                ),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      if (people.isNotEmpty)
        NoGlowScroll(
            child: SingleChildScrollView(
          child: Column(children: [
            for (int index = 0; index < people.length; index++)
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        "Images/avatars/${people[index]["profileIcon"]}.svg",
                        height: 47.4,
                        width: 47.4),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          people[index]["fname"] + " " + people[index]["lname"],
                          style: const TextStyle(
                            fontFamily: "PolySans_Neutral",
                            fontSize: 20,
                            color: Color(0xff212523),
                          ),
                        ),
                        Text(
                          "@${people[index]["username"]}",
                          style: const TextStyle(
                            fontFamily: "Poppins-Light",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff212523),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
          ]),
        ))
      else
        const SizedBox(
          height: 116.67,
          child: Center(
            child: Text(
              "No People found",
              style: TextStyle(
                fontFamily: "PolySans_Median",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color.fromARGB(255, 73, 75, 74),
              ),
            ),
          ),
        ),
    ])));
  }
}
