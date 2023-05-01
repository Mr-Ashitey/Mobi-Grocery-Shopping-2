import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/delete_grocery_list_item_usecase.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_item_repository.mocks.dart';

void main() {
  late MockGroceryListItemRepository mockGroceryListItemRepository;
  late DeleteGroceryListItemUseCase deleteGroceryListItemUseCase;

  setUp(() {
    mockGroceryListItemRepository = MockGroceryListItemRepository();
    deleteGroceryListItemUseCase =
        DeleteGroceryListItemUseCase(mockGroceryListItemRepository);
  });
  const groceryListId = 1234567890;
  const groceryListItemId = 999999999;
  test('DeleteGroceryListItemUseCase should delete a grocery list item',
      () async {
    // Arrange
    when(mockGroceryListItemRepository.deleteGroceryListItem(any, any))
        .thenAnswer((_) async => const Right(null));

    // Act
    await deleteGroceryListItemUseCase.call(groceryListId, groceryListItemId);

    // Assert
    verify(mockGroceryListItemRepository.deleteGroceryListItem(any, any));
  });
}
