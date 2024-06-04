import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/product_filters.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/products.dart';
import 'package:my_app/ui/product_quantity_update.dart';
import 'package:my_app/ui/side_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = "/dashboard";
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];
  List<Product> cart = [];
  bool isLoadingProducts = true;

  var backendUrl = "https://shop-mobile-app-4.onrender.com";
  // var backendUrl = "https://localhost:4000";
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    // TODO: implement initState
    var dataProvider = Provider.of<ProductsProvider>(context, listen: false);
    dataProvider.fetchProducts();
    super.initState();
  }

  filterItemHandler(String name) async {
    var dataProvider = Provider.of<ProductsProvider>(context, listen: false);
    dataProvider.filterProducts(name);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (context, data, child) {
      return Scaffold(
        key: _key, // Assign the key to Scaffold.

        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 56,
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
                    .singleWhere(
                        (product) => product.id == data.selectedProduct)
                    .name,
              )
            : null,
        body: Column(
          children: [
            const SizedBox(
              height: 26,
            ),
            Filters(
              filterItem: filterItemHandler,
            ),
            const SizedBox(
              height: 26,
            ),
            !data.isLoadingProducts
                ? Products(
                    products: data.products,
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: LoadingSpinner(),
                  ),
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
