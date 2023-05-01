import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/grocery_list_item_entity.dart';
import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemUseCase {
  final GroceryListItemRepository repository;

  GetGroceryListItemUseCase(this.repository);

  Future<Either<Failure, GroceryListItemEntity>> call(
      int groceryListId, int id) async {
    return await repository.getGroceryListItem(groceryListId, id);
  }
}
