import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/add_to_cart.dart';
import 'package:my_app/ui/container.dart';
import 'package:my_app/ui/product_comments.dart';
import 'package:my_app/ui/product_rating.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/side_bar.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Cr
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      key: _key,
      extendBody: false,
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
      bottomNavigationBar: dataProvider.selectedProduct != null
          ? AddToCart(
              productName: widget.product.name,
            )
          : null,
      body: SingleChildScrollView(
        child: ShopContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.product.name.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium,
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      // if (widget.product.onStack)
                      GestureDetector(
                          onTap: () => {
                                dataProvider.setProduct(
                                  widget.product.id,
                                ),
                                dataProvider.quantity = 1
                              },
                          child: SvgPicture.asset(
                            'assets/images/cart.svg',
                            color: shopAction,
                            width: 30,
                            height: 30,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                            color: widget.product.onStack
                                ? const Color.fromRGBO(48, 231, 99, 1)
                                : Colors.red,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      const SizedBox(
                        width: 9.5,
                      ),
                      Text(
                        widget.product.onStack ? "On Stack" : "Off stack",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
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
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.details,
                        style: const TextStyle(
                          color: Colors.black,
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
                    style: Theme.of(context).textTheme.headlineSmall,
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
                                      color: Colors.white,
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
                                    color: shopAction,
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
