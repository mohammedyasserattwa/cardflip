import 'package:cardflip/data/Repositories/user_state.dart';
import 'package:cardflip/models/badges_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BadgePopUp extends ConsumerWidget {
  int badgeIndex;
  BadgePopUp({required this.badgeIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(UserDataProvider);
    BadgesModel badge = BadgesModel(currentUser: userData!);

    final String badgeTitle = badge.getBadges[badgeIndex].title;
    final String badgeImage = badge.getBadges[badgeIndex].image;
    final String badgeDescription = badge.getBadges[badgeIndex].description;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            badgeTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10),
          Image.asset(
            badgeImage,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(badgeDescription),
          SizedBox(height: 10),
          GestureDetector(
            child: Container(
              width: 100,
              height: 40,
              child: Text('Close'),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
