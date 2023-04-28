import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class UpdateGroceryListUseCase {
  final GroceryListRepository repository;

  UpdateGroceryListUseCase(this.repository);

  Future<void> call(GroceryListEntity groceryList) async {
    await repository.updateGroceryList(groceryList);
  }
}
