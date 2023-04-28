import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class AddGroceryListUseCase {
  final GroceryListRepository repository;

  AddGroceryListUseCase(this.repository);

  Future<void> call(GroceryListEntity groceryList) async {
    await repository.addGroceryList(groceryList);
  }
}
