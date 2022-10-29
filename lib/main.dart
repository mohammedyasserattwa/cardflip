import 'package:flutter/material.dart';
import "screens/home.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Home(),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xff0D0B26),
              primaryColor: Color(0xff0D0B26),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Color(0xffA8A8A8),
            items: [
              new BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_outlined), label: "Library"),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile")
            ],
            // currentIndex: 0,
            // onTap: (){},
          ),
        ),
      ),
    );
  }
}
