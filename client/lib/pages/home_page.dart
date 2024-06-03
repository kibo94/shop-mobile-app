import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/data_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/filters.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/products.dart';
import 'package:my_app/ui/quantity_update.dart';
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
  var backendUrl = "https://e-commerce-api-8p0f.onrender.com";
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    // TODO: implement initState
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.fetchProducts();
    super.initState();
  }

  filterItemHandler(String name) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.filterItems(name);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, data, child) {
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
        bottomNavigationBar:
            data.selectedProduct != null ? const AddToCart() : null,
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
