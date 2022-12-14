import 'package:cardflip/screens/category.dart';
import 'package:cardflip/screens/home.dart';
import "package:go_router/go_router.dart";
import "package:flutter/material.dart";

import '../screens/DeckScreen.dart';
import '../screens/FlashcardScreen.dart';
import '../screens/Login.dart';
import '../screens/Profile.dart';
import '../screens/adddeck.dart';
import '../screens/library.dart';
import '../screens/test.dart';

class RouterModel {
  final GoRouter _krouter = GoRouter(
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
                path: "Deck/:id",
                builder: (BuildContext context, GoRouterState state) {
                  String id = state.params["id"]!;
                  return DeckScreen(id: id);
                },
                routes: [
                  GoRoute(
                      path: "Flashcards",
                      builder: (BuildContext context, GoRouterState state) {
                        String id = state.params["id"]!;
                        return Flashcard(id: id);
                      }),
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
                                (BuildContext context, GoRouterState state) {
                              return Flashcard();
                            }),
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
                      path: "Deck/:id",
                      builder: (BuildContext context, GoRouterState state) {
                          String id = state.params["id"]!;
                          return DeckScreen(id: id);
                        },
                      routes: [
                        GoRoute(
                            path: "Flashcards",
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return Flashcard();
                            }),
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
                          builder: (BuildContext context, GoRouterState state) {
                            return Flashcard();
                          }),
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
  GoRouter get router => _krouter;
}
