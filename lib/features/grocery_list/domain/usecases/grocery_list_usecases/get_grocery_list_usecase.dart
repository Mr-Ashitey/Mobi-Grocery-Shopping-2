import 'package:dartz/dartz.dart';

import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListUseCase {
  final GroceryListRepository repository;

  GetGroceryListUseCase(this.repository);

  Future<Either<String, GroceryListEntity>> call(String id) async {
    return await repository.getGroceryList(id);
  }
}
