import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';
import 'package:provider/provider.dart';

class Filters extends StatefulWidget {
  const Filters(
      {super.key, required this.filterItem, required this.reloadPage});
  final Function(String name) filterItem;
  final Function reloadPage;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String type = "All";
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    return SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.horizontal,
        child: productProvider.filters.isNotEmpty
            ? Row(children: [
                _filter('All', widget.filterItem),
                ...productProvider.filters
                    .map((filter) => _filter(
                          filter,
                          widget.filterItem,
                        ))
                    .toList()
              ]

                // Make api for geting a fil
                )
            : null);
  }

  GestureDetector _filter(String name, Function filterItem) {
    return GestureDetector(
      onTap: () => {
        filterItem(
          name,
        ),
        setState(() {
          type = name;
        })
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: type == name ? shopAction : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: type != name
                ? Border.all(
                    width: 1,
                    color: Colors.black,
                  )
                : null),
        child: Text(
          name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: type == name ? Colors.white : Colors.black,
                fontSize: 22,
              ),
        ),
      ),
    );
  }
}
