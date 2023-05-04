import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/components/grocery_list_card.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mobi_grocery_shopping_2/helpers/alert/custom_progress_dialog.dart';
import 'package:mobi_grocery_shopping_2/helpers/alert/show_snack_alert.dart';
import 'package:provider/provider.dart';

import 'components/dialog_component/add_grocery_list_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create instance variables.
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    fetchGroceryLists();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> fetchGroceryLists() async {
    try {
      // wait for widget tree to be fully built before we call show progress dialog
      Future.delayed(Duration.zero, () {
        showProgressDialog(context);
      });
      await context.read<GroceryManager>().getGroceryLists();

      // ignore: use_build_context_synchronously
      context.pop();
    } catch (error) {
      context.pop();
      showNotification(
          context: context, message: error.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Lists'),
        actions: [
          IconButton(
              onPressed: () => fetchGroceryLists(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Consumer<GroceryManager>(
        builder: (context, provider, _) {
          final groceryLists = provider.groceryLists;
          return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: groceryLists.length,
            itemBuilder: (context, index) {
              final groceryList = groceryLists[index];
              return GroceryListCard(
                  groceryList: groceryList, controller: controller);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // clear controller text
          controller.clear();

          showDialog(
              context: context,
              builder: (_) {
                return AddGroceryListDialog(controller: controller);
              });
        },
      ),
    );
  }
}
