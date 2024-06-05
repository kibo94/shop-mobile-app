import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/product_comments.dart';
import 'package:my_app/ui/product_rating.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage(
      {super.key,
      required this.product,
      required this.cart,
      this.onAddToCartClick});
  static const routeName = "/single-product";
  final Product product;
  final List<CartProductModel> cart;
  final Function(Product)? onAddToCartClick;
  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: const [
          Header(),
        ],
      ),
      bottomNavigationBar: dataProvider.selectedProduct != null
          ? AddToCart(
              productName: widget.product.name,
            )
          : null,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.product.name.toUpperCase(),
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Rating(rating: Util.getRatingForProduct(widget.product)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${Util.getRatingForProduct(widget.product)} / 5',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: const BoxDecoration(),
                child: widget.product.imgUrl == null
                    ? Image.asset("assets/images/unsplash_LSNJ-pltdu8.png")
                    : Image.network(
                        widget.product.imgUrl!,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                height: 22,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.price.toString()} \din',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      GestureDetector(
                          onTap: () => {
                                dataProvider.setProduct(
                                  widget.product.id,
                                ),
                                dataProvider.quantity = 1
                              },
                          child: SvgPicture.asset(
                            'assets/images/cart.svg',
                            color: Colors.black,
                            width: 30,
                            height: 30,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.details,
                        style: const TextStyle(
                          color: shopGrey1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Comments",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  FormField<String>(
                    builder: (state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 17),
                                  decoration: BoxDecoration(
                                      color: shopGrey2,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        hintText: "Enter your comment"),
                                    onChanged: (value) =>
                                        state.didChange(value),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Util.makeActionDependIfUserLogedIn(
                                    context,
                                    () => _addCommnetToProduct(state),
                                  )
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    "Comment",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Comments(
                    product: widget.product,
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addCommnetToProduct(FormFieldState<String> state) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    dataProvider.addCommentToProduct(
      widget.product.id,
      state.value!,
      userProvider.user!.email,
      context,
    );
    controller.clear();
  }
}
