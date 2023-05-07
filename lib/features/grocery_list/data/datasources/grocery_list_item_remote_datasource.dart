import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';

import '../../../../core/error/failure.dart';
import '../model/grocery_list_item_model.dart';

abstract class GrcoeryListItemRemoteDataSource {
  Future<void> addGroceryListItem(GroceryListItemModel groceryListItem);

  Future<void> updateGroceryListItem(GroceryListItemModel groceryListItem);

  Future<void> deleteGroceryListItem(int id);
}

class GroceryListItemRemoteDataSourceImpl
    implements GrcoeryListItemRemoteDataSource {
  final DioClient _dioClient;

  GroceryListItemRemoteDataSourceImpl(this._dioClient);
  @override
  Future<void> addGroceryListItem(GroceryListItemModel groceryListItem) async {
    try {
      await _dioClient.post("/grocery_list_item", groceryListItem.toJson());
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> deleteGroceryListItem(int id) async {
    try {
      await _dioClient.delete("/grocery_list_item?id=eq.$id");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> updateGroceryListItem(
      GroceryListItemModel groceryListItem) async {
    try {
      await _dioClient.patch("/grocery_list_item?id=eq.${groceryListItem.id}",
          groceryListItem.toJson());
    } on Failure {
      rethrow;
    }
  }
}
