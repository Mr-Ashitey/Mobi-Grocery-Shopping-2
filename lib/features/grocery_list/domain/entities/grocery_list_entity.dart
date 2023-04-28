import 'grocery_list_item_entity.dart';

class GroceryListEntity {
  final String id;
  final String name;
  final List<GroceryListItem> groceryListItems;

  GroceryListEntity(
      {required this.id,
      required this.name,
      this.groceryListItems = const <GroceryListItem>[]});
}
