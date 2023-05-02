import 'package:dartz/dartz.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/grocery_list_item_repository.dart';

class GetGroceryListItemsUseCase {
  final GroceryListItemRepository _repository;

  GetGroceryListItemsUseCase(this._repository);

  Future<Either<Failure, List<GroceryListItemEntity>>> call(
      int groceryListId) async {
    return await _repository.getGroceryListItems(groceryListId);
  }
}
