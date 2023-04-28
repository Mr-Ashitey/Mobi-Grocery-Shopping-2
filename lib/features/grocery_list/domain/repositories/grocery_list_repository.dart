import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

abstract class GroceryListRepository {
  Future<List<GroceryListEntity>> getGroceryLists();
  Future<GroceryListEntity> getGroceryList(String id);
  Future<void> addGroceryList(GroceryListEntity groceryList);
  Future<void> updateGroceryList(GroceryListEntity groceryList);
  Future<void> deleteGroceryList(String id);
}
