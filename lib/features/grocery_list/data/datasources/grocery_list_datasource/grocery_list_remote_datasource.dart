import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';

import '../../../../../core/error/failure.dart';
import '../../model/grocery_list_model.dart';

abstract class GrcoeryListRemoteDataSource {
  Future<List<GroceryListModel>> getGroceryLists();

  Future<GroceryListModel> getGroceryList(int id);

  Future<void> addGroceryList(GroceryListModel groceryList);

  Future<void> updateGroceryList(GroceryListModel groceryList);

  Future<void> deleteGroceryList(int id);
}

class GrcoeryListRemoteDataSourceImpl implements GrcoeryListRemoteDataSource {
  final DioClient _dioClient;

  GrcoeryListRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> addGroceryList(GroceryListModel groceryList) async {
    try {
      await _dioClient.post("/api", groceryList.toJson());
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroceryList(int id) async {
    try {
      await _dioClient.delete("/api");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<GroceryListModel> getGroceryList(int id) async {
    try {
      final response = await _dioClient.get("/api");
      return GroceryListModel.fromJson(response.data);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<GroceryListModel>> getGroceryLists() async {
    try {
      final response = await _dioClient.get("/api");
      final groceryLists = response.data
          .map((groceryList) {
            // print("look:$groceryList");
            return GroceryListModel.fromJson(
                groceryList as Map<String, dynamic>);
          })
          .cast<GroceryListModel>()
          .toList();

      return groceryLists;
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> updateGroceryList(GroceryListModel groceryList) async {
    try {
      await _dioClient.put("/api", groceryList.toJson());
    } on Failure {
      rethrow;
    }
  }
}
