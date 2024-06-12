import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/pages/favorites_page.dart';
import 'package:my_app/pages/profile_page.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.globalKey});
  final GlobalKey<ScaffoldState> globalKey;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 20, left: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => widget.globalKey.currentState!.openDrawer(),
            child: SvgPicture.asset(
              'assets/images/menu.svg',
              height: 15,
              width: 10,
              color: shopAction,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Util.makeActionDependIfUserLogedIn(
                          context,
                          () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const FavoritesPage()),
                                  ),
                                )
                              })
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: 25, top: 16, bottom: 16),
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        color: shopAction,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: Container(
                      alignment: Alignment.center,
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: shopAction,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        data.favorites.length.toString(),
                        style: const TextStyle(color: Colors.white, height: 1),
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
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 25, top: 20, bottom: 16),
                        child: SvgPicture.asset(
                          'assets/images/cart.svg',
                          color: shopAction,
                        )),
                    Positioned(
                      top: 15,
                      right: 20,
                      child: Container(
                        alignment: Alignment.center,
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                            color: shopAction,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          data.cart.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: SvgPicture.asset(
                    'assets/images/user.svg',
                    height: 25,
                    color: shopAction,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
