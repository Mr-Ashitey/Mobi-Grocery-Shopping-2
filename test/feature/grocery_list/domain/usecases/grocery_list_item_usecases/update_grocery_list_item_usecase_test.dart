import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/update_grocery_list_item_usecase.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_item_repository.mocks.dart';

void main() {
  late MockGroceryListItemRepository mockGroceryListRepository;
  late UpdateGroceryListItemUseCase updateGroceryListItemUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListItemRepository();
    updateGroceryListItemUseCase =
        UpdateGroceryListItemUseCase(mockGroceryListRepository);
  });
  const groceryListItemId = 1234567890;
  const groceryListItemName = 'New Name';
  const groceryListItemIsComplete = true;

  final groceryListItemEntity = GroceryListItemEntity(
    id: groceryListItemId,
    name: groceryListItemName,
    isCollected: groceryListItemIsComplete,
  );
  test('UpdateGroceryListItemUseCase should update a grocery list item',
      () async {
    // Arrange
    when(mockGroceryListRepository.updateGroceryListItem(groceryListItemEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    await updateGroceryListItemUseCase.call(groceryListItemEntity);

    // Assert
    verify(
        mockGroceryListRepository.updateGroceryListItem(groceryListItemEntity));
  });
}
