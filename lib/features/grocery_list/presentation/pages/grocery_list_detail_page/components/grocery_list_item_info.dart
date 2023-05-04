import 'package:flutter/material.dart';

import '../../../../data/model/grocery_list_model.dart';

class ListItemsInfo extends StatelessWidget {
  const ListItemsInfo({
    super.key,
    required this.groceryList,
  });

  final GroceryListModel? groceryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                buildTextHeader("Not collected"),
                if (groceryList != null &&
                    groceryList!.groceryListItems.isNotEmpty)
                  Text(
                    (groceryList!.numItemsCollected / groceryList!.numItems)
                        .ceil()
                        .toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Text(
              groceryList?.groceryListItems.length.toString() ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Column(
              children: [
                buildTextHeader("Collected"),
                Text(
                  groceryList?.numItemsCollected.toString() ?? "",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text buildTextHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          decoration: TextDecoration.underline,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}
