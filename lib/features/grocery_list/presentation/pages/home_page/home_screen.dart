import 'package:flutter/material.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/components/grocery_list_card.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/widgets/screen_placeholder.dart';
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
    // wait for widget tree to be fully built before we call show progress dialog
    Future.delayed(Duration.zero, () async {
      try {
        // showProgressDialog(context);
        await context.read<GroceryManager>().getGroceryLists();
        // ignore: use_build_context_synchronously
      } catch (error) {
        showNotification(
            context: context, message: error.toString(), isError: true);
      }
    });
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
          if (provider.notifierState == NotifierState.loading) {
            return const CustomProgressIndicator();
          }

          if (groceryLists.isEmpty && provider.errorMessage.isEmpty) {
            return const ScreenPlaceHolder(title: "Start Shopping...");
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(provider.errorMessage),
            );
          }

          return ListView.builder(
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
