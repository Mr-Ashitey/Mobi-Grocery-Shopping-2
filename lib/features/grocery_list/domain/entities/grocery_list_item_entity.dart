class GroceryListItemEntity {
  final String id;
  final String name;
  final bool isCollected;

  GroceryListItemEntity(
      {required this.id, required this.name, this.isCollected = false});
}
