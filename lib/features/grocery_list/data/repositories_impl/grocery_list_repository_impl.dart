import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_repository.dart';

import '../datasources/grocery_list_remote_datasource.dart';

class GroceryListRepositoryImpl extends GroceryListRepository {
  final GroceryListRemoteDataSource groceryListRemoteDataSource;
  final NetworkInfo networkInfo;

  GroceryListRepositoryImpl({
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
        return const Right(null);
      }
      return Left(Failure('No Internet'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroceryList(int id) async {
    try {
      if (await networkInfo.isConnected) {
        await groceryListRemoteDataSource.deleteGroceryList(id);
        return const Right(null);
      }
      return Left(Failure('No Internet'));
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
      return Left(Failure('No Internet'));
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
        return const Right(null);
      }
      return Left(Failure('No Internet'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
