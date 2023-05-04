import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class UpdateGroceryListUseCase {
  final GroceryListRepository _repository;

  UpdateGroceryListUseCase(this._repository);

  Future<Either<Failure, void>> call(
      int id, GroceryListEntity groceryList) async {
    return await _repository.updateGroceryList(id, groceryList);
  }
}
