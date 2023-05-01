import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListUseCase {
  final GroceryListRepository repository;

  GetGroceryListUseCase(this.repository);

  Future<Either<Failure, GroceryListEntity>> call(int id) async {
    return await repository.getGroceryList(id);
  }
}
