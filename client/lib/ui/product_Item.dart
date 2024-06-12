import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/pages/single_product_page.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(
      {super.key,
      required this.product,
      required this.cart,
      required this.onFavoriteClick,
      required this.onAddToCartClick});
  final Product product;
  final List<CartProductModel> cart;
  final Function(Product) onFavoriteClick;
  final Function(Product) onAddToCartClick;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with TickerProviderStateMixin {
  late AnimationController favoriteAnimationControler;
  late Animation favoriteAnimation;
  late AnimationController addToCartAnimationControler;
  late Animation addToCartAnimation;
  @override
  void initState() {
    favoriteAnimationControler = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    favoriteAnimation = ColorTween(
      begin: shopAction,
      end: Colors.red,
    ).animate(favoriteAnimationControler);
    super.initState();
  }

  @override
  void dispose() {
    favoriteAnimationControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SingleProductPage(
                          product: widget.product,
                          cart: widget.cart,
                          onAddToCartClick: (p0) => widget.onAddToCartClick(p0),
                        ))),
              ),
            },
        child: Container(
          decoration: BoxDecoration(
            color: shopSecondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.only(top: 45),
                      child: Image.asset(
                        height: 110,
                        width: 110,
                        'assets/images/product.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 13,
              left: 13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.product.price.toString()} din',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 13,
                left: 13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Util.makeActionDependIfUserLogedIn(
                          context,
                          _onAddProductToFavorites,
                        ),
                      },
                      child: Icon(
                        dataProvider.favorites
                                .where((favorite) =>
                                    favorite.id == widget.product.id)
                                .isNotEmpty
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: favoriteAnimation.value,
                        size: 27,
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: 13,
              right: 13,
              child: GestureDetector(
                  onTap: () => {
                        dataProvider.setProduct(widget.product.id),
                        dataProvider.quantity = 1,
                      },
                  child: SvgPicture.asset(
                    'assets/images/cart.svg',
                    color: shopAction,
                    width: 25,
                    height: 24,
                  )),
            )
          ]),
        ));
  }

  _onAddProductToFavorites() {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    dataProvider.addProductToFavorites(widget.product);
    if (favoriteAnimationControler.value == 1) {
      favoriteAnimationControler.reverse();
      ScaffoldMessenger.of(context).showSnackBar(
        Util.snackBar("The item has been removed from favorites", context),
      );
    } else {
      favoriteAnimationControler.forward();
      ScaffoldMessenger.of(context).showSnackBar(
        Util.snackBar("The item has been added to favorites", context),
      );
    }
  }
}
