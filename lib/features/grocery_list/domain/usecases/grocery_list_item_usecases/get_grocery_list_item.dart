import 'package:dartz/dartz.dart';

import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  GetGroceryListItemUseCase(this.repository);

  Future<Either<String, GroceryListItemEntity>> call(
      String groceryListId, String id) async {
    return await repository.getGroceryListItem(groceryListId, id);
  }
}
