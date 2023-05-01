part 'grocery_list_item_entity.g.dart';

class GroceryListItemEntity {
  final int id;
  final String name;
  final bool isCollected;

  GroceryListItemEntity(
      {required this.id, required this.name, this.isCollected = false});
}
