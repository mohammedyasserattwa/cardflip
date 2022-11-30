import 'package:cardflip/screens/DeckScreen.dart';
import 'package:cardflip/screens/FlashcardScreen.dart';
import 'package:cardflip/screens/adddeck.dart';
import 'package:cardflip/screens/library.dart';
import 'package:cardflip/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "screens/home.dart";
import "screens/profile.dart";
import "screens/login.dart";
import "screens/category.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const Login(),
        routes: [
          GoRoute(
            path: "Home",
            builder: (BuildContext context, GoRouterState state) =>
                const Home(),
            routes: [
              GoRoute(
                path: "Deck",
                builder: (BuildContext context, GoRouterState state) =>
                    DeckScreen(),
                routes: [
                  GoRoute(
                      path: "Flashcards",
                      builder: (BuildContext context, GoRouterState state) =>
                          Flashcard()),
                  GoRoute(
                      path: "Test",
                      builder: (BuildContext context, GoRouterState state) =>
                          const Test()),
                ],
              ),
              GoRoute(
                  path: "Category",
                  builder: (BuildContext context, GoRouterState state) =>
                      const Category(),
                  routes: [
                    GoRoute(
                      path: "Deck",
                      builder: (BuildContext context, GoRouterState state) =>
                          DeckScreen(),
                      routes: [
                        GoRoute(
                            path: "Flashcards",
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    Flashcard()),
                        GoRoute(
                            path: "Test",
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const Test()),
                      ],
                    ),
                  ]),
              GoRoute(
                  path: "Library",
                  builder: (BuildContext context, GoRouterState state) =>
                      const Library(),
                  routes: [
                    GoRoute(
                      path: "Deck",
                      builder: (BuildContext context, GoRouterState state) =>
                          DeckScreen(),
                      routes: [
                        GoRoute(
                            path: "Flashcards",
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    Flashcard()),
                        GoRoute(
                            path: "Test",
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const Test()),
                      ],
                    ),
                    GoRoute(
                        path: "Adddeck",
                        builder: (BuildContext context, GoRouterState state) =>
                            const Adddeck())
                  ]),
              GoRoute(
                path: "Profile",
                builder: (BuildContext context, GoRouterState state) =>
                    const Profile(),
                routes: [
                  GoRoute(
                    path: "Deck",
                    builder: (BuildContext context, GoRouterState state) =>
                        DeckScreen(),
                    routes: [
                      GoRoute(
                          path: "Flashcards",
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  Flashcard()),
                      GoRoute(
                          path: "Test",
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  const Test()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
