import 'package:cardflip/screens/home.dart';
import 'package:cardflip/screens/library.dart';
import 'package:cardflip/screens/profile/profile.dart';
import 'package:cardflip/widgets/navibar.dart';
import "package:flutter/material.dart";

class Navigation extends StatefulWidget {
  Navigation({super.key, this.nav = 0});
  int nav = 0;
  @override
  State<Navigation> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigation> {
  late bool home, library, profile;
  @override
  void initState() {
    if (widget.nav == 0) {
      home = true;
      library = false;
      profile = false;
    } else if (widget.nav == 1) {
      home = false;
      library = true;
      profile = false;
    } else {
      home = false;
      library = false;
      profile = true;
    }
    super.initState();
  }

  Widget getScreen() {
    // print("Hena");
    if (home) {
      return Home();
    } else if (library) {
      return const Library();
    } else {
      return Profile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getScreen(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xff0D0B26),
        ),
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  if (!home) {
                    setState(() {
                      home = true;
                      library = false;
                      profile = false;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/Home.svg",
                    name: "Home",
                    isActive: home,
                  ),
                )),
            GestureDetector(
                onTap: () {
                  if (!library) {
                    setState(() {
                      home = false;
                      library = true;
                      profile = false;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/library.svg",
                    name: "Library",
                    isActive: library,
                  ),
                )),
            GestureDetector(
                onTap: () {
                  if (!profile) {
                    setState(() {
                      home = false;
                      library = false;
                      profile = true;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/profile.svg",
                    name: "Profile",
                    isActive: profile,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
