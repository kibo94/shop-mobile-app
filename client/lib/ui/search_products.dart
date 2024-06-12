import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:provider/provider.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  final TextEditingController searchControler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: shopSecondary,
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            TextFormField(
              expands: false,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.headlineMedium,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.red),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              controller: searchControler,
              onChanged: (value) => {
                // productProvider.searchProducts(
                //   value,
                // )
              },
            ),
            Positioned(
                top: 10,
                right: 15,
                child: GestureDetector(
                  onTap: () => productProvider.searchProducts(
                    searchControler.text,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    height: 25,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
