import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_item_entity.dart';

void main() {
  const groceryListItemModel = GroceryListItemModel(
    groceryListItemId: 1,
    groceryListItemName: 'Milk',
    groceryListItemIsCollected: false,
    groceryListId: 1,
  );
  test("GrcoeryListItemModel should be a subclass of GroceryListItemEntity",
      () {
    // assert
    expect(groceryListItemModel, isA<GroceryListItemEntity>());
  });
  test('GroceryListItemModel should be created with the correct properties',
      () {
    expect(groceryListItemModel.id, 1);
    expect(groceryListItemModel.name, 'Milk');
    expect(groceryListItemModel.isCollected, false);
  });

  test('GroceryListItemModel should be able to be converted to JSON', () {
    final json = groceryListItemModel.toJson();
    expect(json['name'], 'Milk');
    expect(json['collected'], false);
    expect(json['grocery_list_id'], 1);
  });

  test(
      'GroceryListItemModel should be able to be created from JSON and convert String id from server to int',
      () {
    final json = {
      'id': '1',
      'name': 'Milk',
      'isCollected': false,
    };

    final groceryListItemModel = GroceryListItemModel.fromJson(json);

    expect(groceryListItemModel.id, 1);
    expect(groceryListItemModel.name, 'Milk');
    expect(groceryListItemModel.isCollected, false);
  });
  test(
      'GroceryListItemModel should be able to be created from JSON with right property types',
      () {
    final json = {
      'id': 1,
      'name': 'Milk',
      'isCollected': false,
    };

    final groceryListItemModel = GroceryListItemModel.fromJson(json);

    expect(groceryListItemModel.id, 1);
    expect(groceryListItemModel.name, 'Milk');
    expect(groceryListItemModel.isCollected, false);
  });
}
