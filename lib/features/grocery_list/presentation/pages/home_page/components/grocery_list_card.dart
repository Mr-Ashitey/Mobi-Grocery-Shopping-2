import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';

import '../../../../../../config/route_path.dart';
import 'dialog_component/manage_grocery_list_dialog.dart';

class GroceryListCard extends StatelessWidget {
  final GroceryListModel groceryList;
  final TextEditingController controller;

  const GroceryListCard(
      {super.key, required this.groceryList, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("${RoutePath.viewGroceryListRoutePath}/${groceryList.id}");
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: groceryList.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(2, -7),
                          child: Text(
                            " ${groceryList.groceryListItems.length}",
                            //superscript is usually smaller in size
                            // textScaleFactor: 0.7,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    child: LinearProgressIndicator(
                      value: groceryList.groceryListItems.isEmpty
                          ? 0
                          : groceryList.numItemsCollected /
                              groceryList.numItems,
                      minHeight: 5,
                      backgroundColor: Colors.grey[200],
                      color: Colors.black,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    controller.text = groceryList.name;
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return ManageGroceryList(
                              controller: controller, groceryList: groceryList);
                        });
                  },
                  icon: const Icon(Icons.more_vert_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
