import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/grocery_list_item_entity.dart';

abstract class GroceryListItemRepository {
  Future<Either<Failure, void>> addGroceryListItem(
      GroceryListItemEntity groceryListItem);

  Future<Either<Failure, void>> updateGroceryListItem(
      GroceryListItemEntity groceryListItem);

  Future<Either<Failure, void>> deleteGroceryListItem(int id);
}
