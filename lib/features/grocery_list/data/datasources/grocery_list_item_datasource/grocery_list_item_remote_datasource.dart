import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';

import '../../../../../core/error/failure.dart';
import '../../model/grocery_list_item_model.dart';

abstract class GrcoeryListItemRemoteDataSource {
  Future<List<GroceryListItemModel>> getGroceryListItems(int groceryListId);

  Future<GroceryListItemModel> getGroceryListItem(int groceryListId, int id);

  Future<void> addGroceryListItem(
      int groceryListId, GroceryListItemModel groceryListItem);

  Future<void> updateGroceryListItem(
      int groceryListId, int id, GroceryListItemModel groceryListItem);

  Future<void> deleteGroceryListItem(int groceryListId, int id);
}

class GrcoeryListItemRemoteDataSourceImpl
    implements GrcoeryListItemRemoteDataSource {
  final DioClient _dioClient;

  GrcoeryListItemRemoteDataSourceImpl(this._dioClient);
  @override
  Future<void> addGroceryListItem(
      int groceryListId, GroceryListItemModel groceryListItem) async {
    try {
      await _dioClient.post("/api/$groceryListId", groceryListItem.toJson());
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroceryListItem(int groceryListId, int id) async {
    try {
      await _dioClient.delete("/api");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<GroceryListItemModel> getGroceryListItem(
      int groceryListId, int id) async {
    try {
      final response = await _dioClient.get("/api/$groceryListId");
      return GroceryListItemModel.fromJson(response.data);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<GroceryListItemModel>> getGroceryListItems(
      int groceryListId) async {
    try {
      final response = await _dioClient.get("/api");
      final groceryLists = response.data
          .map((groceryList) => GroceryListItemModel.fromJson(groceryList))
          .cast<GroceryListItemModel>()
          .toList();

      return groceryLists;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> updateGroceryListItem(
      int groceryListId, int id, GroceryListItemModel groceryListItem) async {
    try {
      await _dioClient.put("/api/$groceryListId", groceryListItem.toJson());
    } on Failure {
      rethrow;
    }
  }
}
