import 'package:dartz/dartz.dart';

import '../entities/grocery_list_item_entity.dart';

abstract class GroceryListItemRepository {
  Future<Either<String, List<GroceryListItemEntity>>> getGroceryListItems(
      String groceryListId);
  Future<Either<String, GroceryListItemEntity>> getGroceryListItem(
      String groceryListId, String id);
  Future<void> addGroceryListItem(GroceryListItemEntity groceryListItem);
  Future<void> updateGroceryListItem(GroceryListItemEntity groceryListItem);
  Future<void> deleteGroceryListItem(String groceryListId, String id);
}
