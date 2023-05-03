import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../../helpers/alert/show_progress_dialog.dart';
import '../../../../../../helpers/alert/show_snack_alert.dart';
import '../../../../data/model/grocery_list_item_model.dart';
import '../../../provider/grocery_manager.dart';
import 'dialog_component/add_edit_grocery_list_item.dart';

class GroceryListItemCard extends StatelessWidget {
  final GroceryListItemEntity item;
  final int groceryListId;

  const GroceryListItemCard(
      {super.key, required this.item, required this.groceryListId});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AddEditGroceryListItem(
                      isEdit: true,
                      itemName: item.name,
                      itemId: item.id,
                      isCollected: item.isCollected,
                      groceryListId: groceryListId,
                    );
                  });
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) async {
              try {
                showDialog(
                    context: context,
                    builder: (_) {
                      return const CircularProgressIndicator.adaptive();
                    });
                await context
                    .read<GroceryManager>()
                    .deleteGroceryListItem(groceryListId, item.id);

                // ignore: use_build_context_synchronously
                context.pop();
              } catch (error) {
                context.pop();
                showNotification(
                    context: context, message: error.toString(), isError: true);
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: CheckboxListTile(
        onChanged: (changedValue) async {
          try {
            showProgressDialog(context);
            final updateGroceryListItem = GroceryListItemModel(
                groceryListItemId: item.id,
                groceryListItemName: item.name,
                groceryListItemIsCollected: changedValue!,
                groceryListId: groceryListId);

            await context
                .read<GroceryManager>()
                .updateGroceryListItem(updateGroceryListItem);

            // ignore: use_build_context_synchronously
            context.pop(); // pop back from dialog screen
          } catch (error) {
            context.pop();
            showNotification(
                context: context, message: error.toString(), isError: true);
          }
        },
        value: item.isCollected,
        activeColor: Colors.green,
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        secondary: const Icon(Icons.local_grocery_store_rounded),
        checkboxShape: const CircleBorder(),
      ),
    );
  }
}
