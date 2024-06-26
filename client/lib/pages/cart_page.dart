import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';
import 'package:my_app/ui/cart_products.dart';
import 'package:my_app/ui/container.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/side_bar.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:my_app/ui/bottom_navigation_bar.dart' as bottom_bar;

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  final routeName = "/cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: true);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => _key.currentState!.openDrawer(),
          child: SvgPicture.asset(
            'assets/images/menu.svg',
            width: 26,
            color: shopAction,
          ),
        ),
        actions: [
          Header(
            globalKey: _key,
          ),
        ],
      ),
      drawer: SideBar(barKey: _key),
      bottomNavigationBar: dataProvider.cart.isNotEmpty
          ? bottom_bar.BottomNavigationBar(
              child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 35)),
                    Text(
                        '${Util.getTotalInCart(dataProvider.cart).toString()} din',
                        style: const TextStyle(
                          fontSize: 35,
                          color: Color.fromRGBO(23, 22, 22, 0.22),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ActionButton(
                    btnColor: shopAction,
                    onDone: () => {
                      Util.makeActionDependIfUserLogedIn(
                        context,
                        () => userProvider.checkout(dataProvider.cart, context),
                      )
                    },
                    btnName: "Checkout",
                  ),
                ),
              ],
            ))
          : null,
      body: ShopContainer(
        child: SingleChildScrollView(
          child: dataProvider.cart.isNotEmpty
              ? const Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Cart",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      CartProducts(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 120,
                  width: MediaQuery.of(context).size.width,
                  child: const Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      "The cart is empty",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
