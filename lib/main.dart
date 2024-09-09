import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lalalala/provider/AuthProvider.dart';
import 'package:lalalala/provider/ScoreProvider.dart';
import 'package:lalalala/widget/GameHomePage.dart';
import 'package:lalalala/widget/MenuHomePage.dart';
import 'package:lalalala/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
      ],
      child: MaterialApp.router(
        title: '2048 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router, // Utilise routerConfig
      ),
    );
  }
}
