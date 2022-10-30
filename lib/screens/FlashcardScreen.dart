import "package:flutter/material.dart";

import '../widgets/navibar.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/backgrounds/FlashcardBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Text(""),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Images/backgrounds/close_button.png")),
                ),
              ),
              Container(
                child: Text(""),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Images/icons/more.png")),
                ),
              )
            ]),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
