import 'package:flutter/material.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class QuantityUpdate extends StatelessWidget {
  const QuantityUpdate(
      {super.key,
      required this.product,
      required this.isUpading,
      required this.quantity});
  final bool isUpading;
  final CartProductModel product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductsProvider>(context, listen: false);
    return Container(
      width: 130,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 6.5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 1,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.25)),
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () =>
                dataProvider.subtractOneFromQuantity(product, isUpading),
            child: Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1.5, color: Color.fromRGBO(0, 0, 0, 0.25))
                  ]),
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () => dataProvider.addOneToQuantity(product, isUpading),
            child: Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 1.5, color: Color.fromRGBO(0, 0, 0, 0.25))
                  ]),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
