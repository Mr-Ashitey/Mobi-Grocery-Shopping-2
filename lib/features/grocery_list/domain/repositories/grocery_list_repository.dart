import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

import '../../../../core/error/failure.dart';

abstract class GroceryListRepository {
  Future<Either<Failure, List<GroceryListEntity>>> getGroceryLists();

  Future<Either<Failure, GroceryListEntity>> getGroceryList(int id);

  Future<Either<Failure, void>> addGroceryList(GroceryListEntity groceryList);

  Future<Either<Failure, void>> updateGroceryList(
      int id, GroceryListEntity groceryList);

  Future<Either<Failure, void>> deleteGroceryList(int id);
}
