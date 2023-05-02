import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListUseCase {
  final GroceryListRepository _repository;

  GetGroceryListUseCase(this._repository);

  Future<Either<Failure, GroceryListEntity>> call(int id) async {
    return await _repository.getGroceryList(id);
  }
}
