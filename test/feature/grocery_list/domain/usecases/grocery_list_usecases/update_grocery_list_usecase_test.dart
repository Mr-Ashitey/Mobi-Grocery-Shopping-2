import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/update_grocery_list_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_helpers/reusable_mocks.mocks.dart';

void main() {
  late MockGroceryListRepository mockGroceryListRepository;
  late UpdateGroceryListUseCase updateGroceryListUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListRepository();
    updateGroceryListUseCase =
        UpdateGroceryListUseCase(mockGroceryListRepository);
  });
  const groceryListEntity = GroceryListEntity(
    id: 1234567890,
    name: 'My Grocery List',
    groceryListItems: [],
  );

  final updatedGroceryListEntity = GroceryListEntity(
    id: groceryListEntity.id,
    name: 'New Name',
    groceryListItems: groceryListEntity.groceryListItems,
  );
  test('UpdateGroceryListUseCase should update a grocery list', () async {
    // Arrange
    when(mockGroceryListRepository.updateGroceryList(
            groceryListEntity.id, updatedGroceryListEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    await updateGroceryListUseCase.call(
        groceryListEntity.id!, updatedGroceryListEntity);

    // Assert
    verify(mockGroceryListRepository.updateGroceryList(
        groceryListEntity.id, updatedGroceryListEntity));
  });
}
