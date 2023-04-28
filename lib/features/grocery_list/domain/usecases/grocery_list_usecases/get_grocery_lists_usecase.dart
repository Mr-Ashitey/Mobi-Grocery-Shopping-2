import 'package:dartz/dartz.dart';
import '../../entities/grocery_list_entity.dart';
import '../../repositories/grocery_list_repository.dart';

class GetGroceryListsUseCase {
  final GroceryListRepository repository;

  GetGroceryListsUseCase(this.repository);

  Future<Either<String, List<GroceryListEntity>>> call() async {
    return await repository.getGroceryLists();
  }
}
