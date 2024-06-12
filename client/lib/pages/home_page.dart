import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/button.dart';
import 'package:my_app/ui/container.dart';
import 'package:my_app/ui/product_filters.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/products.dart';
import 'package:my_app/ui/search_products.dart';
import 'package:my_app/ui/side_bar.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  static const routeName = "/";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];
  List<Product> cart = [];
  bool isLoadingProducts = true;
  var networkListener;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    fetchData();
    checkInternet();
    super.initState();
  }

  @override
  void dispose() {
    networkListener?.cancel();
    super.dispose();
  }

  filterItemHandler(String name) async {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    dataProvider.filterProducts(name);
  }

  fetchData() {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    dataProvider.fetchProducts(context);
    dataProvider.fetchFilters();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    return Consumer<ProductProvider>(builder: (context, data, child) {
      return Scaffold(
        key: _key, // Assign the key to Scaffold.
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            Header(
              globalKey: _key,
            ),
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
        body: ShopContainer(
          child: userProvider.isUserOnline
              ? Column(
                  children: [
                    const SizedBox(
                      height: 26,
                    ),
                    SearchProducts(),
                    const SizedBox(
                      height: 26,
                    ),
                    Filters(
                      reloadPage: () => {
                        data.fetchProducts(context),
                        setState((() {})),
                        data.fetchFilters()
                      },
                      filterItem: filterItemHandler,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    !data.isLoadingProducts
                        ? Products(
                            products: data.products,
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: LoadingSpinner(),
                            )),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "No internet connection,please turn on you internet",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                    // ActionButton(onDone: () => {}, btnName: "Reload page"),
                  ],
                ),
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }

  checkInternet() async {
    networkListener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          if (userProvider.isUserOnline == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              Util.snackBar("Back online again", context, color: Colors.green),
            );
          }
          userProvider.setUserOnline(true);
          fetchData();

          break;
        case InternetStatus.disconnected:
          if (userProvider.isUserOnline) {
            ScaffoldMessenger.of(context).showSnackBar(
              Util.snackBar("No internet", context, color: Colors.red),
            );
          }
          userProvider.setUserOnline(false);

          // The internet is now disconnected
          break;
      }
    });
  }
}
