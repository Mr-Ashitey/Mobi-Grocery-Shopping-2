import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemUseCase {
  final GroceryListItemRepository _repository;

  GetGroceryListItemUseCase(this._repository);

  Future<Either<Failure, GroceryListItemEntity>> call(
      int groceryListId, int id) async {
    return await _repository.getGroceryListItem(groceryListId, id);
  }
}
