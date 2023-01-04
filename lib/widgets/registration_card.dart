import 'package:cardflip/models/userModel.dart';
import "package:flutter/material.dart";

class RegistrationCard extends StatelessWidget {
  const RegistrationCard({
    Key? key,
    required double cardWidth,
    required double cardHeight,
    required this.model,
    required this.child,
  })  : _cardWidth = cardWidth,
        _cardHeight = cardHeight,
        super(key: key);

  final double _cardWidth;
  final double _cardHeight;
  final UserModel model;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
            width: (MediaQuery.of(context).size.height > 652)
                ? _cardWidth
                : _cardWidth - 50,
            height: (MediaQuery.of(context).size.height > 751)
                ? _cardHeight
                : (MediaQuery.of(context).size.height > 652)
                    ? _cardHeight - 100
                    : _cardHeight - 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(model.getImages[2]), fit: BoxFit.fill),
            ),
            child: child)
      ],
    );
  }
}
