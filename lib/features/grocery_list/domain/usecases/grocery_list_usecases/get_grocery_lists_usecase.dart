import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

import '../../repositories/grocery_list_repository.dart';

class GetGroceryListsUseCase {
  final GroceryListRepository repository;

  GetGroceryListsUseCase(this.repository);

  Future<List<GroceryListEntity>> call() async {
    return await repository.getGroceryLists();
  }
}
