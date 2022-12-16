import 'package:cardflip/models/routerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    RouterModel routerModel = RouterModel();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: routerModel.router.routeInformationParser,
      routerDelegate: routerModel.router.routerDelegate,
    );
  }
}
