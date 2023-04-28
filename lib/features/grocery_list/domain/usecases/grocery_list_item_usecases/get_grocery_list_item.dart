import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';

import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  GetGroceryListItemUseCase(this.repository);

  Future<GroceryListItemEntity> call(String groceryListId, String id) async {
    return await repository.getGroceryListItem(groceryListId, id);
  }
}
