import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class AddGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  AddGroceryListItemUseCase(this.repository);

  Future<void> call(GroceryListItemEntity groceryListItem) async {
    await repository.addGroceryListItem(groceryListItem);
  }
}
