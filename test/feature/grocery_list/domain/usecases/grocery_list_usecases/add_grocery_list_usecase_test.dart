import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/add_grocery_list_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_helpers/reusable_mocks.mocks.dart';

void main() {
  late MockGroceryListRepository mockGroceryListRepository;
  late AddGroceryListUseCase addGroceryListUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListRepository();
    addGroceryListUseCase = AddGroceryListUseCase(mockGroceryListRepository);
  });

  const groceryListEntity = GroceryListEntity(
    id: 1234567890,
    name: 'My Grocery List',
    groceryListItems: [],
  );
  test('should add grocery list usecase', () async {
    // arrange
    when(mockGroceryListRepository.addGroceryList(groceryListEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    await addGroceryListUseCase.call(groceryListEntity);

    // Assert
    verify(mockGroceryListRepository.addGroceryList(groceryListEntity));
  });
}
