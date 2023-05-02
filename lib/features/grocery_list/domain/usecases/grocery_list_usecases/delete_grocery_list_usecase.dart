import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/grocery_list_repository.dart';

class DeleteGroceryListUseCase {
  final GroceryListRepository _repository;

  DeleteGroceryListUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) async {
    return await _repository.deleteGroceryList(id);
  }
}
