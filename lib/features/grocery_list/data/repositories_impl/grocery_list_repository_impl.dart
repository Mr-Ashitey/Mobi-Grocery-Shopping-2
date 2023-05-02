import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_datasource/grocery_list_local_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_repository.dart';

import '../datasources/grocery_list_datasource/grocery_list_remote_datasource.dart';

class GroceryListRepositoryImpl extends GroceryListRepository {
  final GroceryListLocalDataSource groceryListLocalDataSource;
  final GroceryListRemoteDataSource groceryListRemoteDataSource;
  final NetworkInfo networkInfo;

  GroceryListRepositoryImpl({
    required this.groceryListLocalDataSource,
    required this.groceryListRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, void>> addGroceryList(
      GroceryListEntity groceryList) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListRemoteDataSource
            .addGroceryList(groceryList as GroceryListModel);
        await groceryListLocalDataSource.addGroceryList(groceryList);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroceryList(int id) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListRemoteDataSource.deleteGroceryList(id);
        await groceryListLocalDataSource.deleteGroceryList(id);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroceryListEntity>> getGroceryList(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final groceryListModel =
            await groceryListRemoteDataSource.getGroceryList(id);

        return Right(groceryListModel);
      }
      final groceryListModel =
          await groceryListLocalDataSource.getGroceryList(id);
      return Right(groceryListModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GroceryListEntity>>> getGroceryLists() async {
    try {
      if (await networkInfo.isConnected) {
        final groceryLists =
            await groceryListRemoteDataSource.getGroceryLists();
        return Right(groceryLists);
      }
      final groceryLists = await groceryListLocalDataSource.getGroceryLists();
      return Right(groceryLists);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroceryList(
      int id, GroceryListEntity groceryList) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListRemoteDataSource.updateGroceryList(
            id, groceryList as GroceryListModel);
        await groceryListLocalDataSource.updateGroceryList(id, groceryList);
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
