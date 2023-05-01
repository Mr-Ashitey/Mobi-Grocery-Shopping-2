import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../../../../core/error/failure.dart';
import '../../model/grocery_list_item_model.dart';

abstract class GrcoeryListItemLocalDataSource {
  Future<List<GroceryListItemModel>> getGroceryListItems(int groceryListId);

  Future<GroceryListItemModel> getGroceryListItem(int groceryListId, int id);

  Future<void> addGroceryListItem(
      int groceryListId, GroceryListItemModel groceryListItem);

  Future<void> updateGroceryListItem(
      int groceryListId, int id, GroceryListItemModel groceryListItem);

  Future<void> deleteGroceryListItem(int groceryListId, int id);
}

class GroceryListItemLocalDataSourceImpl
    implements GrcoeryListItemLocalDataSource {
  final String _groceryListJsonFile = "assets/grocery_lists.json";
  final JsonDecoder _decoder;
  final AssetBundle _rootBundle;
  final File _file;

  GroceryListItemLocalDataSourceImpl(
      JsonDecoder? decoder, AssetBundle? constructorRootBundle, File? file)
      : _decoder = decoder ?? const JsonDecoder(),
        _rootBundle = constructorRootBundle ?? rootBundle,
        _file = file ?? File("assets/grocery_lists.json");
  @override
  Future<void> addGroceryListItem(
      int groceryListId, GroceryListItemModel groceryListItem) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final index =
          jsonList.indexWhere((json) => int.parse(json['id']) == groceryListId);
      if (index != -1) {
        jsonList[index]['groceryListItems'] = groceryListItem.toJson();
        await _saveJsonFile(jsonEncode(jsonList));
      } else {
        throw Failure('Grocery list with id ${groceryListItem.id} not found');
      }
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<void> deleteGroceryListItem(int groceryListId, int id) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final index = jsonList.indexWhere((json) => int.parse(json['id']) == id);
      if (index != -1) {
        jsonList[index]['groceryListItems'].removeAt(index);
        await _saveJsonFile(jsonEncode(jsonList));
      } else {
        throw Exception('Grocery list with id $id not found');
      }
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<GroceryListItemModel> getGroceryListItem(
      int groceryListId, int id) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final json = jsonList.firstWhere(
          (groceryList) => int.parse(groceryList['id']) == id,
          orElse: () => null);

      if (json != null) {
        final index = json['groceryListItems']
            .indexWhere((item) => int.parse(item['id']) == id);

        if (index != -1) {
          return GroceryListItemModel.fromJson(json['groceryListItems'][index]);
        }
        throw Failure('Grocery list with id $id not found');
      }
      throw Failure('Grocery list with id $id not found');
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<List<GroceryListItemModel>> getGroceryListItems(
      int groceryListId) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final List<GroceryListItemModel> groceryListItemModels = [];
      final json = jsonList.firstWhere(
          (groceryList) => int.parse(groceryList['id']) == groceryListId,
          orElse: () => null);

      if (json != null) {
        for (final groceryListItem in json['groceryListItems']) {
          groceryListItemModels
              .add(GroceryListItemModel.fromJson(groceryListItem));
        }
      } else {
        throw Failure('Grocery list items not found');
      }
      return groceryListItemModels;
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<void> updateGroceryListItem(
      int groceryListId, int id, GroceryListItemModel groceryListItem) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final index =
          jsonList.indexWhere((json) => int.parse(json['id']) == groceryListId);
      if (index != -1) {
        final itemIndex = jsonList[index]['groceryListItems']
            .indexWhere((item) => int.parse(item['id']) == id);

        if (index != -1) {
          jsonList[index]['groceryListItems'][itemIndex] =
              groceryListItem.toJson();
          await _saveJsonFile(jsonEncode(jsonList));
          return;
        }
        throw Failure('Grocery list item not found');
        // jsonList[index] = groceryList.toJson();
        // await _saveJsonFile(jsonEncode(jsonList));
      } else {
        throw Failure('Grocery list not found');
      }
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  Future<String> _loadJsonFile() async {
    try {
      return _rootBundle.loadString(_groceryListJsonFile);
    } on FileSystemException {
      // Handle file system exception
      rethrow;
    }
  }

  Future<void> _saveJsonFile(String jsonStr) async {
    // Use a local file storage implementation to save the JSON string to file
    // This implementation is specific to your app's needs and requirements
    // final file = File(_groceryListJsonFile);
    try {
      await _file.writeAsString(jsonStr);
    } on FormatException {
      // Handle file system exception
      rethrow;
    }
  }
}
