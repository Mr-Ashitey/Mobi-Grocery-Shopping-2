import 'package:dartz/dartz.dart';

import '../../repositories/grocery_list_repository.dart';

class DeleteGroceryListUseCase {
  final GroceryListRepository repository;

  DeleteGroceryListUseCase(this.repository);

  Future<Either<String, void>> call(String id) async {
    return await repository.deleteGroceryList(id);
  }
}
