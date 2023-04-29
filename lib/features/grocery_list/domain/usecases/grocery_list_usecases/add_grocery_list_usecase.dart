import 'package:dartz/dartz.dart';

import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class AddGroceryListUseCase {
  final GroceryListRepository repository;

  AddGroceryListUseCase(this.repository);

  Future<Either<String, void>> call(GroceryListEntity groceryList) async {
    return await repository.addGroceryList(groceryList);
  }
}
