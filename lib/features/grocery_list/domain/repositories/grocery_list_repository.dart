import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

abstract class GroceryListRepository {
  Future<Either<String, List<GroceryListEntity>>> getGroceryLists();
  Future<Either<String, GroceryListEntity>> getGroceryList(String id);
  Future<void> addGroceryList(GroceryListEntity groceryList);
  Future<void> updateGroceryList(GroceryListEntity groceryList);
  Future<void> deleteGroceryList(String id);
}
