import '../../repositories/grocery_list_item_repository.dart';

class DeleteGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  DeleteGroceryListItemUseCase(this.repository);

  Future<void> call(String groceryListId, String id) async {
    await repository.deleteGroceryListItem(groceryListId, id);
  }
}
