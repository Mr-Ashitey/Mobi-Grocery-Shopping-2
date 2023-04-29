import 'package:dartz/dartz.dart';

import '../../repositories/grocery_list_item_repository.dart';

class DeleteGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  DeleteGroceryListItemUseCase(this.repository);

  Future<Either<String, void>> call(String groceryListId, String id) async {
    return await repository.deleteGroceryListItem(groceryListId, id);
  }
}
