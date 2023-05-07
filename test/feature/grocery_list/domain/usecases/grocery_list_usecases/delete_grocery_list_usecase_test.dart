import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/delete_grocery_list_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_helpers/reusable_mocks.mocks.dart';

void main() {
  late MockGroceryListRepository mockGroceryListRepository;
  late DeleteGroceryListUseCase deleteGroceryListUseCase;

  setUp(() {
    mockGroceryListRepository = MockGroceryListRepository();
    deleteGroceryListUseCase =
        DeleteGroceryListUseCase(mockGroceryListRepository);
  });

  const groceryListEntity = GroceryListEntity(
    id: 1234567890,
    name: 'My Grocery List',
    groceryListItems: [],
  );
  test('should delete grocery list usecase', () async {
    // arrange
    when(mockGroceryListRepository.deleteGroceryList(groceryListEntity.id))
        .thenAnswer((_) async => const Right(null));

    // Act
    await deleteGroceryListUseCase.call(groceryListEntity.id!);

    // Assert
    verify(mockGroceryListRepository.deleteGroceryList(groceryListEntity.id));
  });
}
