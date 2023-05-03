import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:provider/provider.dart';

import '../../../../../../../helpers/alert/show_snack_alert.dart';
import '../../../../../data/model/grocery_list_item_model.dart';

class AddEditGroceryListItem extends StatelessWidget {
  final bool isEdit;
  final String itemName;
  final int groceryListId;
  final int itemId;
  final bool isCollected;
  const AddEditGroceryListItem({
    super.key,
    this.isEdit = false,
    this.itemName = "",
    required this.groceryListId,
    this.itemId = 0,
    this.isCollected = false,
  });

  @override
  Widget build(BuildContext context) {
    String newName = "";
    return AlertDialog(
      title: Text(
        isEdit ? "Edit Item" : "Add Item",
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      content:
          context.watch<GroceryManager>().notifierState == NotifierState.loading
              ? const CircularProgressIndicator.adaptive()
              : Autocomplete<GroceryListItemModel>(
                  displayStringForOption: (groceryItem) => groceryItem.name,
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<GroceryListItemModel>.empty();
                    }

                    final allGroceryItems =
                        context.read<GroceryManager>().getAllGroceryItems();
                    return allGroceryItems
                        .where((groceryItem) => groceryItem.name
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    textEditingController.text = itemName;
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      onChanged: (value) => newName = value,
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 2,
                        child: SizedBox(
                          width: 300,
                          height: 200,
                          child: ListView.builder(
                              itemCount: options.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, index) {
                                final option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                    newName = option.name;
                                  },
                                  child: ListTile(
                                    title: Text(option.name),
                                  ),
                                );
                              }),
                        ),
                      ),
                    );
                  },
                ),
      actions: [
        TextButton.icon(
            key: const Key('new_item_btn'),
            onPressed: context.watch<GroceryManager>().notifierState ==
                    NotifierState.loading
                ? null
                : () async {
                    try {
                      if (newName.isEmpty) {
                        return;
                      }
                      if (isEdit) {
                        final updateGroceryList = GroceryListItemModel(
                          groceryListItemId: itemId,
                          groceryListItemName: newName,
                          groceryListId: groceryListId,
                          groceryListItemIsCollected: isCollected,
                        );
                        await context
                            .read<GroceryManager>()
                            .updateGroceryListItem(updateGroceryList);
                        // ignore: use_build_context_synchronously
                        context.pop();
                        return;
                      }
                      final newGroceryList = GroceryListItemModel(
                          groceryListItemName: newName,
                          groceryListId: groceryListId);
                      await context
                          .read<GroceryManager>()
                          .addGroceryListItem(groceryListId, newGroceryList);
                      // ignore: use_build_context_synchronously
                      context.pop();
                      return;
                    } catch (error) {
                      context.pop();
                      showNotification(
                          context: context,
                          message: error.toString(),
                          isError: true);
                    }
                  },
            icon: const Icon(
              Icons.local_grocery_store_rounded,
              color: Colors.black,
            ),
            label: Text(
              isEdit ? "Edit Shopping Item" : "Add Shopping Item",
              style: const TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}
