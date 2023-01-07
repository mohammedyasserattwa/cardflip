// ignore_for_file: unnecessary_string_interpolations

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cardflip/data/Repositories/user_decks.dart';
import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/models/deckModel.dart';
import 'package:cardflip/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_glow_scroll/no_glow_scroll.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import '../data/card_generator.dart';
import '../models/flashcardModel.dart';
import "../widgets/term_card.dart" as TermCard;
import 'package:cardflip/data/card.dart' as dataCard;

class DeckScreen extends ConsumerStatefulWidget {
  String id;
  DeckScreen({Key? key, this.id = "1"}) : super(key: key);

  @override
  ConsumerState<DeckScreen> createState() => _MyDeckScreenState();
}

class _MyDeckScreenState extends ConsumerState<DeckScreen> {
  late FlashcardModel model;
  final heartState = ["heart_outline", "heart_filled"];
  final CardGenerator _cardGen = CardGenerator();

  late Widget _cards;
  bool _isFiltered = false;
  int counter = 0;
  late int _randomBanner;

  @override
  void initState() {
    super.initState();

    model = FlashcardModel(id: widget.id);
    _cards = cardList(model.getCards);
    _randomBanner = Random().nextInt(6);
  }

  Widget cardList(List<dataCard.Card> cardList) {
    return Expanded(
      child: NoGlowScroll(
        child: ListView(
          children: [
            for (int index = 0; index < cardList.length; index += 2)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: (index + 1 < cardList.length)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    for (int i = 0;
                        i <= (index + 1 < cardList.length ? 1 : 0);
                        i++)
                      TermCard.Card(
                        id: widget.id,
                        index: cardList[index + i].id,
                        cardName: cardList[index + i].term,
                        path:
                            "Images/cards/librarypage/${_cardGen.getcolor}/${_cardGen.getshape}.png",
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget filter() => GestureDetector(
      onTap: () {
        setState(() {
          if (_isFiltered == false) {
            model.filter();
            _cards = cardList(model.getCards);
            _isFiltered = true;
          }
        });
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          color: Color(0xf1A0404),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset("Images/icons/svg/filter.svg",
              width: 45, height: 45),
        ),
      ));
  @override
  Widget build(BuildContext context) {
    final deckModel = DeckModel();
    final userModel = UserModel();
    final favourites = ref.watch(FavouritesProvider);
    final ratings = ref.watch(RatingProvider);
    final reports = ref.watch(ReportProvider);
    // final userID = userModel.id;
    final userID = "01f4bll7";
    bool isReported = (reports.contains(model.deck.id));
    dynamic size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Images/backgrounds/deckpage.png"),
              fit: BoxFit.cover),
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: 410,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Images/banners/deckpage/$_randomBanner.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Images/icons/arrow-left-s-line.png"),
                                      fit: BoxFit.cover),
                                ),
                                width: 40,
                                height: 40,
                                child: const Text(""))),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: PopupMenuButton(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            icon: SvgPicture.asset(
                                "Images/icons/svg/more-fill.svg"),
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                enabled: !isReported,
                                onTap: () {
                                  if (!reports.contains(model.deck.id)) {
                                    ref.read(ReportProvider.notifier).state =
                                        reports + [model.deck.id];
                                    isReported = true;
                                  }
                                },
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    Icon(Icons.flag),
                                    SizedBox(width: 10),
                                    Text("Report"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () => Future(() => Navigator.pushNamed(
                                    context, '/leaderboard',
                                    arguments: {"deckID": widget.id})),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    Icon(Icons.leaderboard_outlined),
                                    SizedBox(width: 10),
                                    Text("Leaderboard"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // const SizedBox(height: 25),
                    AutoSizeText(
                      model.deck.deckName,
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      stepGranularity: 1,
                      style: TextStyle(
                        fontFamily: "PolySans_Median",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize:
                            (MediaQuery.of(context).size.width > 320) ? 48 : 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        model.deck.deckDescription,
                        style: const TextStyle(
                          fontFamily: "PolySans_Neutral",
                          fontWeight: FontWeight.w500,
                          color: Color(0xff514F55),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${model.queue} Flashcards",
                              style: TextStyle(
                                fontFamily: "PolySans_Median",
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff514F55),
                                fontSize:
                                    (MediaQuery.of(context).size.width > 322)
                                        ? 30
                                        : 22,
                              ),
                            ),
                            if (deckModel.deckByUserID(userID).isEmpty ||
                                widget.id !=
                                    deckModel.deckByUserID(userID)[0].deckID)
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (!favourites
                                            .contains(model.deck.id)) {
                                          model.deck.incrementRating();
                                          ref
                                              .read(FavouritesProvider.notifier)
                                              .state = favourites + [model.deck.id];
                                        } else {
                                          model.deck.decrementRating();
                                          List<String> temp = ref
                                              .read(FavouritesProvider.notifier)
                                              .state;
                                          temp.remove(model.deck.id);
                                          ref
                                              .read(FavouritesProvider.notifier)
                                              .state = temp;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: const BoxDecoration(
                                          color: Color(0x0f1a0404),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "Images/icons/svg/${heartState[favourites.contains(model.deck.id) ? 1 : 0]}.svg",
                                              width: 45,
                                              height: 45),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  filter()
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (deckModel.deckByUserID(userID).isEmpty ||
                                  widget.id !=
                                      deckModel.deckByUserID(userID)[0].deckID)
                                GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "Images/icons/profile.png"),
                                                      fit: BoxFit.cover),
                                                ),
                                                width: 35,
                                                height: 35,
                                                child: const Text("")),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              model.deck.deckAuthor,
                                              style: const TextStyle(
                                                fontFamily: "PolySans_Slim",
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff514F55),
                                                fontSize: 22,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              GestureDetector(
                                  onTap: () {
                                    if (!ratings.contains(model.deck.id)) {
                                      model.deck.incrementRating();
                                      ref.read(RatingProvider.notifier).state =
                                          ratings + [model.deck.id];
                                    } else {
                                      model.deck.decrementRating();
                                      List<String> temp = ref
                                          .read(RatingProvider.notifier)
                                          .state;
                                      temp.remove(model.deck.id);
                                      ref.read(RatingProvider.notifier).state =
                                          <String>[] + temp;
                                      setState(() {});
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Images/icons/star-${(ratings.contains(model.deck.deckID)) ? "fill" : "line"}.png"),
                                                fit: BoxFit.cover),
                                          ),
                                          width: 23,
                                          height: 23,
                                          child: const Text("")),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        model.deck.deckRating,
                                        style: const TextStyle(
                                          fontFamily: "PolySans_Slim",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff514F55),
                                          fontSize: 23,
                                        ),
                                      ),
                                    ],
                                  )),
                              if (deckModel.deckByUserID(userID).isNotEmpty &&
                                  widget.id ==
                                      deckModel.deckByUserID(userID)[0].deckID)
                                Row(
                                  children: [
                                    GestureDetector(
                                        child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        color: Color(0xf1A0404),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            "Images/icons/svg/edit.svg",
                                            width: 28,
                                            height: 28),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/addFlashcards");
                                        },
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: const BoxDecoration(
                                            color: Color(0xf1A0404),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "Images/icons/svg/add.svg",
                                                width: 25,
                                                height: 25),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    filter()
                                  ],
                                )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/flashcards',
                      arguments: {"deckID": widget.id});
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Images/icons/bar.png"),
                        fit: BoxFit.cover),
                  ),
                  width: 136.71,
                  height: 55,
                  child: const Center(
                    child: Text(
                      "Study",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "PolySans_Median",
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Future(() => Navigator.pushNamed(context, '/test',
                    arguments: {"deckID": widget.id})),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Images/icons/bar.png"),
                        fit: BoxFit.cover),
                  ),
                  width: 136.71,
                  height: 55,
                  child: const Center(
                    child: Text(
                      "Test",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "PolySans_Median",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _cards
        ]),
      ),
    );
  }
}
