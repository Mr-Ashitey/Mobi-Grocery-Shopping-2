import 'package:dartz/dartz.dart';

import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class UpdateGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  UpdateGroceryListItemUseCase(this.repository);

  Future<Either<String, void>> call(
      GroceryListItemEntity groceryListItem) async {
    return await repository.updateGroceryListItem(groceryListItem);
  }
}
