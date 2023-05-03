import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';

import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

void main() {
  const groceryListModel = GroceryListModel(
    groceryListId: 1,
    groceryListName: 'My Grocery List',
    groceryListItemsModel: [
      GroceryListItemModel(
        groceryListItemId: 1,
        groceryListItemName: 'Milk',
        groceryListItemIsCollected: false,
      ),
      GroceryListItemModel(
        groceryListItemId: 2,
        groceryListItemName: 'Eggs',
        groceryListItemIsCollected: false,
      ),
    ],
  );

  test("GrcoeryListModel should be a subclass of GroceryListEntity", () {
    // assert
    expect(groceryListModel, isA<GroceryListEntity>());
  });
  test('GroceryListModel should be created with the correct properties', () {
    expect(groceryListModel.id, 1);
    expect(groceryListModel.name, 'My Grocery List');
    expect(groceryListModel.groceryListItems.length, 2);
  });

  test('GroceryListModel should be able to be converted to JSON', () {
    final json = groceryListModel.toJson();

    expect(json['name'], 'My Grocery List');
  });

  test(
      'GroceryListModel should be able to be created from JSON and should pass evene when groceryListItems is empty',
      () {
    final json = {
      'id': 1,
      'name': 'My Grocery List',
      'groceryListItems': [],
    };
    final groceryListModel = GroceryListModel.fromJson(json);

    expect(groceryListModel.id, 1);
    expect(groceryListModel.name, 'My Grocery List');
    expect(groceryListModel.groceryListItems.length, 0);
  });
  // test(
  //     'GroceryListModel should be able to be created from JSON and should convert string id to int',
  //     () {
  //   final json = {
  //     'id': '1',
  //     'name': 'My Grocery List',
  //     'groceryListItems': [],
  //   };
  //   final groceryListModel = GroceryListModel.fromJson(json);

  //   expect(groceryListModel.id, 1);
  //   expect(groceryListModel.name, 'My Grocery List');
  //   expect(groceryListModel.groceryListItems.length, 2);
  // });
  test(
      'GroceryListModel should be able to be created from JSON with right property types',
      () {
    final json = {
      'id': 1,
      'name': 'My Grocery List',
      'grocery_list_item': [
        {
          'id': 1,
          'name': 'Milk',
          'isCollected': false,
        },
        {
          'id': 2,
          'name': 'Eggs',
          'isCollected': false,
        },
      ],
    };
    final groceryListModel = GroceryListModel.fromJson(json);

    expect(groceryListModel.id, 1);
    expect(groceryListModel.name, 'My Grocery List');
    expect(groceryListModel.groceryListItems.length, 2);
  });
}
