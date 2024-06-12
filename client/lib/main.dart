import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/models/single_product_arguments.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/register_page.dart';
import 'package:my_app/pages/single_product_page.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

var mHttpOverrides = MyHttpOverrides();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseApi().initNotifications();

  HttpOverrides.global = mHttpOverrides;

  run();
}

void run() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.myNavigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        var routes = {
          MyHomePage.routeName: (context) => const MyHomePage(),
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          SingleProductPage.routeName: (context) {
            final args = settings.arguments as SingleProductArguments;
            return SingleProductPage(
              product: args.product,
              cart: args.cart,
              onAddToCartClick: args.onAddToCartClick,
            );
          },
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
      theme: shopTheme,
    );
  }
}
