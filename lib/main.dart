import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lalalala/widget/GameHomePage.dart';
import 'package:lalalala/widget/MenuHomePage.dart';
import 'package:lalalala/provider/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MenuHomePage(),
      ),
      GoRoute(
        path: '/play',
        builder: (context, state) => const GameHomePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp.router(
        title: '2048 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // Enlève le bandeau "Debug"
        routerConfig:
        _router, // Utilise routerConfig au lieu de routerDelegate et routeInformationParser
      ),
    );
  }
}
