import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/get_grocery_list_items_usecase.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_item_repository.mocks.dart';

void main() {
  late MockGroceryListItemRepository mockGroceryListItemRepository;
  late GetGroceryListItemsUseCase getGroceryListItemsUseCase;

  setUp(() {
    mockGroceryListItemRepository = MockGroceryListItemRepository();
    getGroceryListItemsUseCase =
        GetGroceryListItemsUseCase(mockGroceryListItemRepository);
  });
  final expectedGroceryListItemEntity1 = GroceryListItemEntity(
    id: 1234567890,
    name: 'Milk',
    isCollected: false,
  );

  final expectedGroceryListItemEntity2 = GroceryListItemEntity(
    id: 9876543210,
    name: 'Other Grocery Item',
    isCollected: true,
  );

  final expectedGroceryListItemList = [
    expectedGroceryListItemEntity1,
    expectedGroceryListItemEntity2,
  ];
  test('GetGroceryListItemsUseCase should get a list of grocery list items',
      () async {
    // Arrange
    when(mockGroceryListItemRepository.getGroceryListItems(any))
        .thenAnswer((_) async => Right(expectedGroceryListItemList));

    // Act
    final actualGroceryListItemList = await getGroceryListItemsUseCase
        .call(expectedGroceryListItemList[0].id!);

    // Assert
    expect(actualGroceryListItemList, Right(expectedGroceryListItemList));
  });
}
