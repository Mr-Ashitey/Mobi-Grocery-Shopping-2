import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/get_grocery_list_usecase.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_repository.mocks.dart';

void main() {
  late MockGroceryListRepository mockGroceryListRepository;
  late GetGroceryListUseCase getGroceryListUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListRepository();
    getGroceryListUseCase = GetGroceryListUseCase(mockGroceryListRepository);
  });

  test('should get a grocery list', () async {
    // Arrange
    final expectedGroceryListEntity = GroceryListEntity(
      id: '1234567890',
      name: 'My Grocery List',
      groceryListItems: [],
    );

    when(mockGroceryListRepository.getGroceryList(expectedGroceryListEntity.id))
        .thenAnswer((_) async => Right(expectedGroceryListEntity));

    // Act
    final actualGroceryListEntity =
        await getGroceryListUseCase.call(expectedGroceryListEntity.id);

    // Assert
    expect(actualGroceryListEntity, Right(expectedGroceryListEntity));
  });
}
