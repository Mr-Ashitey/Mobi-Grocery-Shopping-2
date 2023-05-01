import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';

import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart';

void main() {
  final groceryListModel = GroceryListModel(
    id: 1,
    name: 'My Grocery List',
    groceryListItems: [
      GroceryListItemModel(
        id: 1,
        name: 'Milk',
        isCollected: false,
      ),
      GroceryListItemModel(
        id: 2,
        name: 'Eggs',
        isCollected: false,
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

    expect(json['id'], 1);
    expect(json['name'], 'My Grocery List');
    expect(json['groceryListItems'].length, 2);
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
      'groceryListItems': [
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
