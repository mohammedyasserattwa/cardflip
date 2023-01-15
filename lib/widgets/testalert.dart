import 'package:cardflip/data/deck.dart';
import 'package:flutter/material.dart';

class TestAlert {
  final Deck deck;
  final BuildContext context;
  late var show;
  TestAlert({required this.deck, required this.context});

  Widget? alert() {
    Future displaytestalert() async {
      show = await Navigator.pushNamed(context, '/test',
          arguments: {"deck": deck});

      if (show)
        return ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
              content: Text(
                  style: TextStyle(fontFamily: "Poppins"),
                  'You can start a test once you have created at least 3 cards!')));
    }

    displaytestalert();
    return null;
  }
}
