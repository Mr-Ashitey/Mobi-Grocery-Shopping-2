import 'grocery_list_item_entity.dart';

class GroceryListEntity {
  final String id;
  final String name;
  final List<GroceryListItemEntity> groceryListItems;

  GroceryListEntity(
      {required this.id,
      required this.name,
      this.groceryListItems = const <GroceryListItemEntity>[]});
}
