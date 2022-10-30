import 'package:cardflip/screens/DeckScreen.dart';
import 'package:cardflip/screens/FlashcardScreen.dart';
import 'package:cardflip/screens/library.dart';
import 'package:flutter/material.dart';
import "screens/home.dart";
import "screens/category.dart";
import 'package:go_router/go_router.dart';
import "widgets/navibar.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final subRoutes = ["/", "Library", "Deck", "Flashcard"];

  final List<Widget> navScreens = [
    const Home(),
    const Library(),
    DeckScreen(),
    const Flashcard()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => navScreens[0],
      //   "/Library": (context) => navScreens[1],
      //   "/Deck": (context) => navScreens[2],
      //   "/Flashcard": (context) => navScreens[3],
      // }
    );
  }
}
