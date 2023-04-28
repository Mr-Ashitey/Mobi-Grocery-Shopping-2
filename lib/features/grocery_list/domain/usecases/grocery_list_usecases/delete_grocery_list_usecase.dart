import '../../repositories/grocery_list_repository.dart';

class DeleteGroceryListUseCase {
  final GroceryListRepository repository;

  DeleteGroceryListUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteGroceryList(id);
  }
}
