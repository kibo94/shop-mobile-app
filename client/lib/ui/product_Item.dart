import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/pages/single_product_page.dart';
import 'package:my_app/providers/data_provider.dart';
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
  final List<Product> cart;
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
    // TODO: implement initState
    favoriteAnimationControler = AnimationController(
      duration: const Duration(milliseconds: 200), //controll animation duration
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    addToCartAnimationControler = AnimationController(
      duration: const Duration(milliseconds: 200), //controll animation duration
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    favoriteAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(favoriteAnimationControler);
    super.initState();
    addToCartAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.black,
    ).animate(addToCartAnimationControler);
    super.initState();
  }

  @override
  void dispose() {
    favoriteAnimationControler.dispose();
    addToCartAnimationControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    // bool inCart = widget.product.inCart;
    bool isFavorite = widget.product.isLiked;
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
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/product.png',
                height: 180,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: Theme.of(context).textTheme.headline3,
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
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              GestureDetector(
                                  onTap: () => {
                                        dataProvider
                                            .setProduct(widget.product.id),
                                        dataProvider.quantity = 1,
                                      },
                                  child: SvgPicture.asset(
                                    'assets/images/cart.svg',
                                    color: Colors.black,
                                    width: 25,
                                    height: 24,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: 10,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      dataProvider.onAddToFavorites(widget.product),
                      if (favoriteAnimationControler.value == 1)
                        {
                          favoriteAnimationControler.reverse(),
                          ScaffoldMessenger.of(context).showSnackBar(
                            Util.snackBar(
                                "The item has been removed from favorites",
                                context),
                          ),
                        }
                      else
                        {
                          favoriteAnimationControler.forward(),
                          ScaffoldMessenger.of(context).showSnackBar(
                            Util.snackBar(
                                "The item has been added to favorites",
                                context),
                          ),
                        }
                    },
                    child: Icon(
                      dataProvider.favorites
                              .where((favorite) =>
                                  favorite.id == widget.product.id)
                              .isNotEmpty
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: favoriteAnimation.value,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
