import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/grocery_list_item_entity.dart';

abstract class GroceryListItemRepository {
  Future<Either<Failure, List<GroceryListItemEntity>>> getGroceryListItems(
      int groceryListId);

  Future<Either<Failure, GroceryListItemEntity>> getGroceryListItem(
      int groceryListId, int id);

  Future<Either<Failure, void>> addGroceryListItem(
      GroceryListItemEntity groceryListItem);

  Future<Either<Failure, void>> updateGroceryListItem(
      GroceryListItemEntity groceryListItem);

  Future<Either<Failure, void>> deleteGroceryListItem(
      int groceryListId, int id);
}
