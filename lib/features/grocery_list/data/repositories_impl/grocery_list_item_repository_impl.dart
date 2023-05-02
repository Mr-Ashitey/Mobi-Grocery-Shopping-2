import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_item_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/grocery_list_item_datasource/grocery_list_item_local_datasource.dart';
import '../datasources/grocery_list_item_datasource/grocery_list_item_remote_datasource.dart';

class GroceryListItemRepositoryImpl extends GroceryListItemRepository {
  final GrcoeryListItemLocalDataSource groceryListItemLocalDataSource;
  final GrcoeryListItemRemoteDataSource groceryListItemRemoteDataSource;
  final NetworkInfo networkInfo;

  GroceryListItemRepositoryImpl(
      {required this.groceryListItemLocalDataSource,
      required this.groceryListItemRemoteDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, void>> addGroceryListItem(
      int groceryListId, GroceryListItemEntity groceryListItem) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource.addGroceryListItem(
            groceryListId, groceryListItem as GroceryListItemModel);
        await groceryListItemLocalDataSource.addGroceryListItem(
            groceryListId, groceryListItem);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroceryListItem(
      int groceryListId, int id) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource.deleteGroceryListItem(
            groceryListId, id);
        await groceryListItemLocalDataSource.deleteGroceryListItem(
            groceryListId, id);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroceryListItemEntity>> getGroceryListItem(
      int groceryListId, int id) async {
    try {
      if (await networkInfo.isConnected) {
        final groceryListModel = await groceryListItemRemoteDataSource
            .getGroceryListItem(groceryListId, id);

        return Right(groceryListModel);
      }
      final groceryListModel = await groceryListItemLocalDataSource
          .getGroceryListItem(groceryListId, id);
      return Right(groceryListModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroceryListItemEntity>>> getGroceryListItems(
      int groceryListId) async {
    try {
      if (await networkInfo.isConnected) {
        final groceryLists = await groceryListItemRemoteDataSource
            .getGroceryListItems(groceryListId);
        return Right(groceryLists);
      }
      final groceryLists = await groceryListItemLocalDataSource
          .getGroceryListItems(groceryListId);
      return Right(groceryLists);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroceryListItem(
      int groceryListId, int id, GroceryListItemEntity groceryListItem) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListItemRemoteDataSource.updateGroceryListItem(
            groceryListId, id, groceryListItem as GroceryListItemModel);
        await groceryListItemLocalDataSource.updateGroceryListItem(
            groceryListId, groceryListItem.id, groceryListItem);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
