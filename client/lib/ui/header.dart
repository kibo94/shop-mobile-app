import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/pages/favorites_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductsProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const FavoritesPage()),
                        ),
                      )
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: shopBlack,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      alignment: Alignment.center,
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        data.favorites.length.toString(),
                        style: const TextStyle(
                          color: shopBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const CartPage()),
                    ),
                  )
                },
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: shopBlack,
                        size: 30,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 12,
                      child: Container(
                        alignment: Alignment.center,
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          data.cart.length.toString(),
                          style: const TextStyle(
                            color: shopBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const ProfilePage()),
                    ),
                  )
                },
                child: SvgPicture.asset('assets/images/user.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
