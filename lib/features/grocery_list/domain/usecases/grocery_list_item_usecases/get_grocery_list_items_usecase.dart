import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';

import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemsUseCase {
  final GroceryListItemRepository repository;

  GetGroceryListItemsUseCase(this.repository);

  Future<List<GroceryListItemEntity>> call(String groceryListId) async {
    return await repository.getGroceryListItems(groceryListId);
  }
}
