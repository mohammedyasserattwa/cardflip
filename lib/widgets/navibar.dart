import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final navItems = {"Home", "Library", "Account"};
  final navIcons = {
    const Icon(Icons.home_rounded),
    const Icon(Icons.library_books_outlined),
    const Icon(Icons.person_outline)
  };
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color(0xff0D0B26),
          primaryColor: Color(0xff0D0B26),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color(0xffA8A8A8),
        onTap: (int label) {
          context.go((label != 0) ? "/" + navItems.elementAt(label) : "/");
        },
        items: new List.generate(
            navItems.length,
            (index) => BottomNavigationBarItem(
                icon: navIcons.elementAt(index),
                label: navItems.elementAt(index))),
      ),
    );
  }
}
