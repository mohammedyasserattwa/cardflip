import 'package:cardflip/screens/DeckScreen.dart';
import 'package:cardflip/screens/library.dart';
import 'package:flutter/material.dart';
import "screens/home.dart";
import 'package:go_router/go_router.dart';
import "widgets/navibar.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final subRoutes = ["Library", "Deck"];

  final List<Widget> navScreens = [const Library(), const DeckScreen()];
  GoRouter router() {
    return GoRouter(routes: [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const Home(),
        routes: List.generate(
            navScreens.length,
            (index) => GoRoute(
                  path: subRoutes[index],
                  builder: (BuildContext context, GoRouterState state) =>
                      navScreens[index],
                )),

        // [
        //   GoRoute(
        //     path: "Library",
        //     builder: (BuildContext context, GoRouterState state) =>
        //         const Library(),
        //   ),
        // ]
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router(),
    );
  }
}

/*
Scaffold(
        body: Home(),
        
      ),
*/
