import 'package:flutter/material.dart';
import 'package:my_app/providers/data_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/quantity_update.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context, listen: true);
    return Container(
      alignment: Alignment.bottomCenter,
      height: 110,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -1),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.25))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => data.setProduct(null),
            child: Container(
              margin: const EdgeInsets.only(bottom: 5, right: 10),
              child: const Icon(
                Icons.close,
                size: 35,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                color: shopGrey2,
                height: 65,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: QuantityUpdate(
                    quantity: data.quantity,
                    product: data.products.singleWhere(
                      (element) => element.id == data.selectedProduct,
                    ),
                    isUpading: false,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  data.onAddToCartClickHanlder(
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
                  color: shopBlack,
                  height: 65,
                  child: Text(
                    "Add to cart",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.white,
                        ),
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
