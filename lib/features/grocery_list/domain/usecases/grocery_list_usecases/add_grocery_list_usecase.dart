import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class AddGroceryListUseCase {
  final GroceryListRepository _repository;

  AddGroceryListUseCase(this._repository);

  Future<Either<Failure, void>> call(GroceryListEntity groceryList) async {
    return await _repository.addGroceryList(groceryList);
  }
}
