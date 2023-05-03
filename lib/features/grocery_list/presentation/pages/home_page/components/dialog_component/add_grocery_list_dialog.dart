import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../../helpers/alert/show_snack_alert.dart';
import '../../../../../data/model/grocery_list_model.dart';
import '../../../../provider/grocery_manager.dart';

class AddGroceryListDialog extends StatelessWidget {
  final TextEditingController controller;
  const AddGroceryListDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "New Grocery List",
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      content: TextField(
        key: const Key('add_new_list'),
        controller: controller,
        cursorColor: Colors.black,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
      actions: [
        context.watch<GroceryManager>().notifierState == NotifierState.loading
            ? const CircularProgressIndicator.adaptive()
            : TextButton.icon(
                key: const Key('add_new_list_btn'),
                onPressed: () async {
                  try {
                    // check if text is empty
                    if (controller.text.isEmpty) {
                      return;
                    }

                    final newGroceryList =
                        GroceryListModel(groceryListName: controller.text);

                    await context
                        .read<GroceryManager>()
                        .addGroceryList(newGroceryList);

                    // ignore: use_build_context_synchronously
                    context.pop();
                  } catch (error) {
                    showNotification(
                        context: context,
                        message: error.toString(),
                        isError: true);
                    context.pop();
                  }
                },
                icon: const Icon(Icons.check, color: Colors.black),
                label: const Text(
                  "Add New List",
                  style: TextStyle(color: Colors.black),
                )),
      ],
    );
  }
}
