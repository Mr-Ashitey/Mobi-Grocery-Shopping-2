import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class UpdateGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  UpdateGroceryListItemUseCase(this.repository);

  Future<void> call(GroceryListItemEntity groceryListItem) async {
    await repository.updateGroceryListItem(groceryListItem);
  }
}
