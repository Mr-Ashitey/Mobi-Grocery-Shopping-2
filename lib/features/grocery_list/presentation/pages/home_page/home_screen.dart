import 'package:flutter/material.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/components/grocery_list_card.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:provider/provider.dart';

import 'components/dialog_component/add_grocery_list_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create an instance variable.
  late final Future getGroceryListsFuture;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    getGroceryListsFuture = context.read<GroceryManager>().getGroceryLists();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery Lists')),
      body: FutureBuilder(
        future: context.read<GroceryManager>().getGroceryLists(),
        // future: getGroceryListsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final groceryLists = context.watch<GroceryManager>().groceryLists;
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
