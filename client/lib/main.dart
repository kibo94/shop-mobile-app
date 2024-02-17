import 'package:flutter/material.dart';
import 'package:my_app/pages/auth_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        var routes = {
          '/': (context) => const AuthPage(),
        };
        if (settings.name == '/') {
          WidgetBuilder? builder = routes[settings.name];
          if (builder == null) {
            throw "err";
          }
          return MaterialPageRoute(
            settings: settings,
            builder: (ctx) => builder(ctx),
          );
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
