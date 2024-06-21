import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/dialogs/confirm_dialog.dart';
import 'package:my_app/ui/product_quantity_update.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({super.key, required this.product});
  final CartProductModel product;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width - 40,
      padding: const EdgeInsets.only(top: 20, bottom: 0, left: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: shopSecondary,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/product.png',
                        fit: BoxFit.cover,
                        height: 105,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("Black",
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(182, 176, 176, 0.13)),
                        child: Text(
                          widget.product.type!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      QuantityUpdate(
                        product: widget.product,
                        quantity: dataProvider.cart
                            .singleWhere(
                                (element) => element.id == widget.product.id)
                            .quantity,
                        isUpading: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 10),
                    child: Text(
                        "${widget.product.price * widget.product.quantity} din",
                        style: const TextStyle(
                          fontSize: 25,
                        )),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 16,
            child: GestureDetector(
              onTap: () async => {
                await showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                          onNo: () => Navigator.of(context).pop(),
                          onYes: () => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              Util.snackBar(
                                "The product has been removed from cart",
                                context,
                              ),
                            ),
                            dataProvider.removeProductFromCart(widget.product),
                            Navigator.of(context).pop()
                          },
                          title:
                              "Are you sure that you want to\nremove this item",
                        ))
              },
              child: SvgPicture.asset(
                'assets/images/remove_bin.svg',
                color: shopAction,
                height: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
