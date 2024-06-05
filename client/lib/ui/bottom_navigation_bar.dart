import 'package:flutter/material.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 162,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7.5,
              color: Colors.black,
              offset: Offset(1.5, 1.5),
            )
          ],
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [child],
        ));
  }
}
