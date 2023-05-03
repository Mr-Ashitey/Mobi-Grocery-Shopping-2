import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_item_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/grocery_list_item_remote_datasource.dart';

class GroceryListItemRepositoryImpl extends GroceryListItemRepository {
  final GrcoeryListItemRemoteDataSource groceryListItemRemoteDataSource;
  final NetworkInfo networkInfo;

  GroceryListItemRepositoryImpl(
      {required this.groceryListItemRemoteDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, void>> addGroceryListItem(
      GroceryListItemEntity groceryListItem) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource
            .addGroceryListItem(groceryListItem as GroceryListItemModel);
        // await groceryListItemLocalDataSource.addGroceryListItem(
        //     groceryListId, groceryListItem);
        return const Right(null);
      }
      return Left(Failure("No Internet"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroceryListItem(int id) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource.deleteGroceryListItem(id);
        // await groceryListItemLocalDataSource.deleteGroceryListItem(id);
        return const Right(null);
      }
      return Left(Failure("No Internet"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroceryListItem(
      GroceryListItemEntity groceryListItem) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource
            .updateGroceryListItem(groceryListItem as GroceryListItemModel);
        // await groceryListItemLocalDataSource.updateGroceryListItem(
        //     groceryListId, groceryListItem.id, groceryListItem);
        return const Right(null);
      }
      return Left(Failure("No Internet"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
