import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.rating, this.onRate});
  final Function(int rating)? onRate;
  final int rating;

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rating = 1;
  @override
  @override
  Widget build(BuildContext context) {
    return getRating();
  }

  Row getRating() {
    List<Widget> children = [];
    for (var i = 0; i < 5; i++) {
      // if(widget.product)
      if (i < widget.rating) {
        children.add(
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: GestureDetector(
              onTap: () => {
                if (widget.onRate != null) {widget.onRate!(i + 1)}
              },
              child: SvgPicture.asset(
                "assets/images/star.svg",
                color: Color.fromARGB(255, 210, 203, 20),
              ),
            ),
          ),
        );
      } else {
        children.add(
          GestureDetector(
            onTap: () => {
              if (widget.onRate != null) {widget.onRate!(i + 1)}
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 9),
              child: SvgPicture.asset("assets/images/star.svg",
                  color: const Color.fromRGBO(217, 217, 217, 1)),
            ),
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
