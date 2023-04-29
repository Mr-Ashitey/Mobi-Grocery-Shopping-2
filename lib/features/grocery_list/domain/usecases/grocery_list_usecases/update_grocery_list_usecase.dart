import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class UpdateGroceryListUseCase {
  final GroceryListRepository repository;

  UpdateGroceryListUseCase(this.repository);

  Future<Either<Failure, void>> call(GroceryListEntity groceryList) async {
    return await repository.updateGroceryList(groceryList);
  }
}
