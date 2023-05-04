import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_item_repository.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/add_grocery_list_item_usecase.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_item_repository.mocks.dart';

@GenerateMocks([GroceryListItemRepository])
void main() {
  late MockGroceryListItemRepository mockGroceryListItemRepository;
  late AddGroceryListItemUseCase addGroceryListItemUseCase;

  setUp(() {
    mockGroceryListItemRepository = MockGroceryListItemRepository();
    addGroceryListItemUseCase =
        AddGroceryListItemUseCase(mockGroceryListItemRepository);
  });
  const groceryListItemId = 1234567890;
  const groceryListItemName = 'Milk';
  const groceryListItemIsComplete = false;

  const groceryListItemEntity = GroceryListItemEntity(
    id: groceryListItemId,
    name: groceryListItemName,
    isCollected: groceryListItemIsComplete,
  );

  test('AddGroceryListItemUseCase should add a grocery list item', () async {
    // Arrange
    when(mockGroceryListItemRepository.addGroceryListItem(any))
        .thenAnswer((_) async => const Right(null));

    // Act
    await addGroceryListItemUseCase.call(groceryListItemEntity);

    // Assert
    verify(mockGroceryListItemRepository
        .addGroceryListItem(groceryListItemEntity));
  });
}
