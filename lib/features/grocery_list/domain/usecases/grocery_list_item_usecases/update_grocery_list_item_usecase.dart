import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class UpdateGroceryListItemUseCase {
  final GroceryListItemRepository _repository;

  UpdateGroceryListItemUseCase(this._repository);

  Future<Either<Failure, void>> call(
      GroceryListItemEntity groceryListItem) async {
    return await _repository.updateGroceryListItem(groceryListItem);
  }
}
