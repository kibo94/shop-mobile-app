import 'package:flutter/material.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/pages/favorites_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/style/theme.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.barKey});
  final GlobalKey<ScaffoldState> barKey;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            color: Colors.white,
            height: 400,
            padding: const EdgeInsets.only(left: 40),
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 83,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const MyHomePage(title: "ss")),
                    ),
                  ),
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const CartPage()),
                    ),
                  ),
                  child: const Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const FavoritesPage()),
                    ),
                  ),
                  child: const Text(
                    "Favorites",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: GestureDetector(
            onTap: () => barKey.currentState!.closeDrawer(),
            child: const Icon(
              Icons.close,
              color: shopBlack,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
