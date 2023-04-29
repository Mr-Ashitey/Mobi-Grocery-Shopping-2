import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/get_grocery_list_item.dart';
import 'package:mockito/mockito.dart';

import 'generated_mocks/generated_grocery_list_item_repository.mocks.dart';

void main() {
  late MockGroceryListItemRepository mockGroceryListItemRepository;
  late GetGroceryListItemUseCase getGroceryListItemUseCase;

  setUp(() {
    mockGroceryListItemRepository = MockGroceryListItemRepository();
    getGroceryListItemUseCase =
        GetGroceryListItemUseCase(mockGroceryListItemRepository);
  });
  const groceryListId = '1234567890';
  const groceryListItemId = '9999999';
  final expectedGroceryListItemEntity = GroceryListItemEntity(
    id: groceryListItemId,
    name: 'Milk',
    isCollected: false,
  );
  test('GetGroceryListItemUseCase should get a grocery list item', () async {
    // Arrange
    when(mockGroceryListItemRepository.getGroceryListItem(
            groceryListId, groceryListItemId))
        .thenAnswer((_) async => Right(expectedGroceryListItemEntity));

    // Act
    final actualGroceryListItemEntity =
        await getGroceryListItemUseCase.call(groceryListId, groceryListItemId);

    // Assert
    expect(actualGroceryListItemEntity, Right(expectedGroceryListItemEntity));
  });
}
