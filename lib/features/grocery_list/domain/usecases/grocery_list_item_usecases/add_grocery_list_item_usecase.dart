import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class AddGroceryListItemUseCase {
  final GroceryListItemRepository _repository;

  AddGroceryListItemUseCase(this._repository);

  Future<Either<Failure, void>> call(
      int groceryListId, GroceryListItemEntity groceryListItem) async {
    return await _repository.addGroceryListItem(groceryListId, groceryListItem);
  }
}
