import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating});
  final int rating;
  @override
  Widget build(BuildContext context) {
    return getRating();
  }

  Row getRating() {
    List<Widget> children = [];
    for (var i = 0; i < 5; i++) {
      // if(widget.product)
      if (i < rating) {
        children.add(
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: SvgPicture.asset(
              "assets/images/star.svg",
              color: Color.fromARGB(255, 210, 203, 20),
            ),
          ),
        );
      } else {
        children.add(
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: SvgPicture.asset("assets/images/star.svg",
                color: const Color.fromRGBO(217, 217, 217, 1)),
          ),
        );
      }
    }
    return Row(
      children: children,
    );
  }
}
