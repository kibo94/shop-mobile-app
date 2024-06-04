import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/models/single_product_arguments.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/pages/register_page.dart';
import 'package:my_app/pages/single_product_page.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

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
Future<void> main() async {
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
          ChangeNotifierProvider(create: (context) => ProductsProvider()),
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
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          MyHomePage.routeName: (context) {
            return const MyHomePage(
              title: "Home",
            );
          },
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
