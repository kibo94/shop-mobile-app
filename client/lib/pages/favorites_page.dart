import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/products.dart';
import 'package:my_app/ui/side_bar.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  final routeName = "/cart";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      key: _key, // A
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => _key.currentState!.openDrawer(),
          child: SvgPicture.asset(
            'assets/images/menu.svg',
            width: 26,
            color: shopBlack,
          ),
        ),
        actions: const [
          Header(),
        ],
      ),
      drawer: SideBar(barKey: _key),
      bottomNavigationBar: data.selectedProduct != null
          ? AddToCart(
              productName: data.products
                  .singleWhere((product) => product.id == data.selectedProduct)
                  .name,
            )
          : null,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text("Favorites", style: Theme.of(context).textTheme.headline1),
            const SizedBox(
              height: 41,
            ),
            data.favorites.isNotEmpty
                ? Products(
                    products: data.favorites,
                  )
                : Text("No favorites")
          ],
        ),
      ),
    );
  }
}
