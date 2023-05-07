import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/helpers/alert/action_confirmation_dialog.dart';
import 'package:mobi_grocery_shopping_2/helpers/alert/custom_progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../../../../helpers/alert/show_snack_alert.dart';
import '../../../../../../../helpers/keyboard.dart';
import '../../../../provider/grocery_manager.dart';

class ManageGroceryList extends StatelessWidget {
  final GroceryListModel groceryList;
  final TextEditingController controller;

  const ManageGroceryList(
      {super.key, required this.controller, required this.groceryList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Manage List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: controller,
              cursorColor: Colors.black,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          const SizedBox(height: 35),
          context.watch<GroceryManager>().notifierState == NotifierState.loading
              ? const CustomProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        key: const Key('rename_grocery_list'),
                        onPressed: () async {
                          try {
                            if (groceryList.name == controller.text) {
                              return;
                            }
                            // rename grocery list
                            final updateGroceryList = GroceryListModel(
                                groceryListName: controller.text);
                            // keyboard
                            hideKeyboard(context);

                            await context
                                .read<GroceryManager>()
                                .updateGroceryList( 
                                    groceryList.id!, updateGroceryList);
                            // ignore: use_build_context_synchronously
                            context.pop();
                          } catch (error) {
                            context.pop();
                            showNotification(
                                context: context,
                                message: error.toString(),
                                isError: true);
                          }
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Rename")),
                    ElevatedButton.icon(
                        key: const Key('delete_grocery_list'),
                        onPressed: () async {
                          try {
                            final confirmDeletion =
                                await confirmDialog(context);

                            if (confirmDeletion != null && confirmDeletion) {
                              // remove grocery list
                              // ignore: use_build_context_synchronously
                              await context
                                  .read<GroceryManager>()
                                  .deleteGroceryList(groceryList.id!);

                              // ignore: use_build_context_synchronously
                              showNotification(
                                  context: context,
                                  message:
                                      "${groceryList.name} Deleted Successfully");
                            }

                            // ignore: use_build_context_synchronously
                            context.pop();
                          } catch (error) {
                            context.pop();
                            showNotification(
                                context: context,
                                message: error.toString(),
                                isError: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 176, 53, 45)),
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete")),
                  ],
                ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
