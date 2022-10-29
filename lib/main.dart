import 'package:cardflip/screens/library.dart';
import 'package:flutter/material.dart';
import "screens/home.dart";
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const Home(),
        routes: [
          GoRoute(
            path: "Library",
            builder: (BuildContext context, GoRouterState state) =>
                const Library(),
          )
        ])
  ]);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

/*
Scaffold(
        body: Home(),
        
      ),
*/
