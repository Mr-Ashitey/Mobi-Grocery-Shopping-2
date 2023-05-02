import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListsUseCase {
  final GroceryListRepository _repository;

  GetGroceryListsUseCase(this._repository);

  Future<Either<Failure, List<GroceryListEntity>>> call() async {
    return await _repository.getGroceryLists();
  }
}
