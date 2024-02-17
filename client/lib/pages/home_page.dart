import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/ui/filters.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/product_Iitem.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];
  bool isLoadingProducts = true;
  final user = FirebaseAuth.instance.currentUser!;

  fetchProdutcs() async {
    setState(() {
      isLoadingProducts = true;
    });
    var data = await http
        .get(Uri.parse('https://e-commerce-api-8p0f.onrender.com/products'));

    Iterable list = await json.decode(data.body);
    var productss = List<Product>.from(
      list.map((e) => Product.fromJson(e)),
    );
    setState(() {
      products = productss;
      isLoadingProducts = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProdutcs();
    super.initState();
  }

  Widget getProducts() {
    List<ProductItem> prds = [];
    products.forEach((product) => {
          prds.add(ProductItem(product: product)),
        });

    return Column(children: prds);
  }

  filterItemHandler(String name) async {
    setState(() {
      isLoadingProducts = true;
    });
    var data = await http.get(Uri.parse(name == 'All'
        ? 'https://e-commerce-api-8p0f.onrender.com/products'
        : 'https://e-commerce-api-8p0f.onrender.com/products?type=${name.toLowerCase()}'));
    Iterable list = await json.decode(data.body);
    var filteredPrds = List<Product>.from(
      list.map((e) => Product.fromJson(e)),
    );
    setState(() {
      products = filteredPrds;
      isLoadingProducts = false;
    });
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Web shop'),
        actions: [
          GestureDetector(
            onTap: (() => _logout()),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(user.email!),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: _logout,
                    child: const Icon(
                      Icons.logout,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Products',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              Filters(
                filterItem: filterItemHandler,
              ),
              !isLoadingProducts
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        getProducts(),
                      ],
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: LoadingSpinner(),
                    ),
            ],
          )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
