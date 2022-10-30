import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';
import '../screens/home.dart';
import "../screens/library.dart";
import '../screens/Profile.dart';

class NavBar extends StatelessWidget {
  final navItems = {"Home", "Library","Profile"};

  final navIcons = {
    const Icon(Icons.home_rounded),
    const Icon(Icons.library_books_outlined),
    const Icon(Icons.person_outline_rounded),
    // const Icon(Icons.person_outline)
  };

  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: const Color(0xff0D0B26),
          primaryColor: const Color(0xff0D0B26),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color(0xffA8A8A8),
        onTap: (int label) {
          if (label == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Home();
            }));
          } else if (label == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Library();
            }));
          } else if (label == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Profile();
            }));
          }
        },
        items: List.generate(
            navItems.length,
            (index) => BottomNavigationBarItem(
                icon: navIcons.elementAt(index),
                label: navItems.elementAt(index))),
      ),
    );
  }
}
