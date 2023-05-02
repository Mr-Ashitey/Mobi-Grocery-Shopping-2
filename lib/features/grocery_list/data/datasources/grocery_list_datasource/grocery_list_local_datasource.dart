import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';

import '../../model/grocery_list_model.dart';

abstract class GroceryListLocalDataSource {
  Future<List<GroceryListModel>> getGroceryLists();

  Future<GroceryListModel> getGroceryList(int id);

  Future<void> addGroceryList(GroceryListModel groceryList);

  Future<void> updateGroceryList(int id, GroceryListModel groceryList);

  Future<void> deleteGroceryList(int id);
}

class GroceryListLocalDataSourceImpl implements GroceryListLocalDataSource {
  final String _groceryListJsonFile = "assets/grocery_lists.json";
  final JsonDecoder _decoder;
  final AssetBundle _rootBundle;
  final File _file;

  GroceryListLocalDataSourceImpl(
      JsonDecoder? decoder, AssetBundle? constructorRootBundle, File? file)
      : _decoder = decoder ?? const JsonDecoder(),
        _rootBundle = constructorRootBundle ?? rootBundle,
        _file = file ?? File("assets/grocery_lists.json");

  @override
  Future<List<GroceryListModel>> getGroceryLists() async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final List<GroceryListModel> groceryListModels = [];
      for (final json in jsonList) {
        groceryListModels.add(GroceryListModel.fromJson(json));
      }
      return groceryListModels;
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<GroceryListModel> getGroceryList(int id) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final json = jsonList.firstWhere(
          (groceryList) => int.parse(groceryList['id']) == id,
          orElse: () => null);

      if (json != null) {
        return GroceryListModel.fromJson(json);
      } else {
        throw Failure('Grocery list with id $id not found');
      }
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<void> addGroceryList(GroceryListModel groceryList) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);
      jsonList.add(groceryList.toJson());
      await _saveJsonFile(jsonEncode(jsonList));
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<void> updateGroceryList(int id, GroceryListModel groceryList) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final index = jsonList.indexWhere((json) => int.parse(json['id']) == id);
      if (index != -1) {
        jsonList[index] = groceryList.toJson();
        await _saveJsonFile(jsonEncode(jsonList));
      } else {
        throw Failure('Grocery list with id ${groceryList.id} not found');
      }
    } catch (error) {
      throw Failure('Error with file: $error');
    }
  }

  @override
  Future<void> deleteGroceryList(int id) async {
    try {
      final jsonStr = await _loadJsonFile();
      final List<dynamic> jsonList = _decoder.convert(jsonStr);

      final index = jsonList.indexWhere((json) => int.parse(json['id']) == id);
      if (index != -1) {
        jsonList.removeAt(index);
        await _saveJsonFile(jsonEncode(jsonList));
      } else {
        throw Exception('Grocery list with id $id not found');
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
