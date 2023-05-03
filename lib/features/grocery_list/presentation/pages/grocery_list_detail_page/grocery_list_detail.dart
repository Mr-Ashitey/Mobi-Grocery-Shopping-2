import 'package:flutter/material.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/grocery_list_detail_page/components/grocery_list_item_card.dart';
import 'package:mobi_grocery_shopping_2/helpers/alert/custom_progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../provider/grocery_manager.dart';
import 'components/dialog_component/add_edit_grocery_list_item.dart';

class ViewGroceryListScreen extends StatefulWidget {
  final int groceryListId;
  const ViewGroceryListScreen({super.key, required this.groceryListId});

  @override
  State<ViewGroceryListScreen> createState() => _ViewGroceryListScreenState();
}

class _ViewGroceryListScreenState extends State<ViewGroceryListScreen> {
  @override
  void initState() {
    super.initState();
    getGroceryList();
  }

  Future<void> getGroceryList() async {
    await context.read<GroceryManager>().getGroceryList(widget.groceryListId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<GroceryManager>().groceryList?.name ?? ""),
      ),
      body: Consumer<GroceryManager>(
        builder: (context, provider, child) {
          final groceryList = provider.groceryList;
          if (groceryList == null) {
            return const CustomProgressIndicator();
          }

          return ListView.builder(
            itemCount: groceryList.groceryListItems.length,
            itemBuilder: (context, index) {
              final item = groceryList.groceryListItems[index];
              return GroceryListItemCard(
                item: item,
                groceryListId: widget.groceryListId,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text("ADD"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AddEditGroceryListItem(
                      groceryListId: widget.groceryListId);
                });
          }),
    );
  }
}
