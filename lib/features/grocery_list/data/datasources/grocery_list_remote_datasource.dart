import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';

import '../../../../core/error/failure.dart';
import '../model/grocery_list_model.dart';

abstract class GroceryListRemoteDataSource {
  Future<List<GroceryListModel>> getGroceryLists();

  Future<void> addGroceryList(GroceryListModel groceryList);

  Future<void> updateGroceryList(int id, GroceryListModel groceryList);

  Future<void> deleteGroceryList(int id);
}

class GrcoeryListRemoteDataSourceImpl implements GroceryListRemoteDataSource {
  final DioClient _dioClient;

  GrcoeryListRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> addGroceryList(GroceryListModel groceryList) async {
    try {
      await _dioClient.post("/grocery_list", groceryList.toJson());
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroceryList(int id) async {
    try {
      await _dioClient.delete("/grocery_list?id=eq.$id");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<GroceryListModel>> getGroceryLists() async {
    try {
      final response = await _dioClient.get(
          "/grocery_list?select=id,name,grocery_list_item(id,name,collected)&order=id.asc");
      final groceryLists = response.data
          .map((groceryList) {
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
  Future<void> updateGroceryList(int id, GroceryListModel groceryList) async {
    try {
      await _dioClient.patch("/grocery_list?id=eq.$id", groceryList.toJson());
    } on Failure {
      rethrow;
    }
  }
}
