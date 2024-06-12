import 'package:flutter/material.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/product_quantity_update.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key, required this.productName});
  final String productName;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider>(context, listen: true);
    return Container(
      alignment: Alignment.bottomCenter,
      height: 180,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 17, left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/product.png',
                      width: 80,
                      height: 75,
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    SizedBox(
                      // width: 250,
                      child: Text(
                        productName,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    color: shopPrimary,
                    height: 65,
                    child: QuantityUpdate(
                      quantity: data.quantity,
                      product: Util.createCartModel(
                          data.products.singleWhere(
                            (element) => element.id == data.selectedProduct,
                          ),
                          data.quantity),
                      isUpading: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      data.addProductToCart(
                        data.products.singleWhere(
                            (element) => element.id == data.selectedProduct),
                      ),
                      ScaffoldMessenger.of(context).showSnackBar(
                        Util.snackBar(
                          "The item has been added to cart",
                          context,
                        ),
                      ),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2,
                      color: shopAction,
                      height: 65,
                      child: Text(
                        "Add to cart",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () => data.setProduct(null),
              child: const Icon(
                Icons.close,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
