import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      builder: ((context) => const MyHomePage()),
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
          top: 45,
          child: GestureDetector(
              onTap: () => barKey.currentState!.closeDrawer(),
              child: SvgPicture.asset(
                'assets/images/close-side.svg',
                color: shopAction,
              )),
        ),
      ],
    );
  }
}
