import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/grocery_list_item_repository.dart';

class DeleteGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  DeleteGroceryListItemUseCase(this.repository);

  Future<Either<Failure, void>> call(int groceryListId, int id) async {
    return await repository.deleteGroceryListItem(groceryListId, id);
  }
}
