import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/grocery_list_item_repository.dart';

class DeleteGroceryListItemUseCase {
  final GroceryListItemRepository _repository;

  DeleteGroceryListItemUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) async {
    return await _repository.deleteGroceryListItem(id);
  }
}
