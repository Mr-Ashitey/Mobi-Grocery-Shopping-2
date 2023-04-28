import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListUseCase {
  final GroceryListRepository repository;

  GetGroceryListUseCase(this.repository);

  Future<GroceryListEntity> call(String id) async {
    return await repository.getGroceryList(id);
  }
}
