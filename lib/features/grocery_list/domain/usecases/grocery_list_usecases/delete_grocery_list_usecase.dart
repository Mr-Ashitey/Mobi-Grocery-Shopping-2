import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/grocery_list_repository.dart';

class DeleteGroceryListUseCase {
  final GroceryListRepository repository;

  DeleteGroceryListUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteGroceryList(id);
  }
}
