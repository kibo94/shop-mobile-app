import 'package:flutter/material.dart';
import 'package:my_app/ui/container.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShopContainer(
      child: Container(
          height: 162,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [child],
          )),
    );
  }
}
