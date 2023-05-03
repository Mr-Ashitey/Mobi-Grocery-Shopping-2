import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';

import '../../../../../../config/route_path.dart';
import 'dialogs/manage_grocery_list.dart';

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
                  Text(
                    groceryList.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${groceryList.groceryListItems.length} items',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    controller.text = groceryList.name;
                    showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 3),
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