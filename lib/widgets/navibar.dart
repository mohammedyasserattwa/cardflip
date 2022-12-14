import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';
import '../screens/home.dart';
import "../screens/library.dart";
import '../screens/Profile.dart';
import "../data/Repositories/navigator_state.dart" as Navigator;

class NavBar extends ConsumerWidget {
  final navItems = {"Home", "Library", "Profile"};

  final navIcons = {
    const Icon(Icons.home_rounded),
    const Icon(Icons.library_books_outlined),
    const Icon(Icons.person_outline_rounded),
    // const Icon(Icons.person_outline)
  };

  NavBar({super.key});

  late List<bool> active;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    active = ref.watch(Navigator.NavigatorState);
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
        currentIndex: active.indexOf(true),
        onTap: (int label) {
          if (label == 1) {
            ref.read(Navigator.NavigatorState.notifier).state = [
              false,
              true,
              false
            ];
            GoRouter.of(context).go('/Home/Library');
          } else if (label == 0) {
            ref.read(Navigator.NavigatorState.notifier).state = [
              true,
              false,
              false
            ];
            GoRouter.of(context).go('/Home');
          } else if (label == 2) {
            ref.read(Navigator.NavigatorState.notifier).state = [
              false,
              false,
              true
            ];
            GoRouter.of(context).go('/Home/Profile');
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
