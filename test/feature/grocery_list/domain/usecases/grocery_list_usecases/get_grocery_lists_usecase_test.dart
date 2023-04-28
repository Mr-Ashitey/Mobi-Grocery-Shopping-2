import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/get_grocery_lists_usecase.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_repository.mocks.dart';

void main() {
  late MockGroceryListRepository mockGroceryListRepository;
  late GetGroceryListsUseCase getGroceryListsUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListRepository();
    getGroceryListsUseCase = GetGroceryListsUseCase(mockGroceryListRepository);
  });
  final expectedGroceryListEntity1 = GroceryListEntity(
    id: '1234567890',
    name: 'My Grocery List',
    groceryListItems: [],
  );

  final expectedGroceryListEntity2 = GroceryListEntity(
    id: '9876543210',
    name: 'Other Grocery List',
    groceryListItems: [],
  );

  final expectedGroceryListList = [
    expectedGroceryListEntity1,
    expectedGroceryListEntity2,
  ];

  test('should get a list of grocery lists', () async {
    // Arrange
    when(mockGroceryListRepository.getGroceryLists())
        .thenAnswer((_) async => Right(expectedGroceryListList));

    // Act
    final actualGroceryListList = await getGroceryListsUseCase.call();

    // Assert
    expect(actualGroceryListList, Right(expectedGroceryListList));
  });
}
