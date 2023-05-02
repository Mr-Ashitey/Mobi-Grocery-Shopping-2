import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class UpdateGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  UpdateGroceryListItemUseCase(this.repository);

  Future<Either<Failure, void>> call(
      int groceryListId, int id, GroceryListItemEntity groceryListItem) async {
    return await repository.updateGroceryListItem(
        groceryListId, id, groceryListItem);
  }
}
