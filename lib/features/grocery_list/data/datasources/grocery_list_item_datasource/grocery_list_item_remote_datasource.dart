import '../../model/grocery_list_item_model.dart';

abstract class GrcoeryListRemoteDataSource {
  Future<List<GroceryListItemModel>> getGroceryListItems(int groceryListId);

  Future<GroceryListItemModel> getGroceryListItem(int groceryListId, int id);

  Future<void> addGroceryListItem(GroceryListItemModel groceryListItem);

  Future<void> updateGroceryListItem(GroceryListItemModel groceryListItem);

  Future<void> deleteGroceryListItem(int groceryListId, int id);
}

class GrcoeryListRemoteDataSourceImpl implements GrcoeryListRemoteDataSource {
  @override
  Future<void> addGroceryListItem(GroceryListItemModel groceryListItem) {
    // TODO: implement addGroceryListItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGroceryListItem(int groceryListId, int id) {
    // TODO: implement deleteGroceryListItem
    throw UnimplementedError();
  }

  @override
  Future<GroceryListItemModel> getGroceryListItem(int groceryListId, int id) {
    // TODO: implement getGroceryListItem
    throw UnimplementedError();
  }

  @override
  Future<List<GroceryListItemModel>> getGroceryListItems(int groceryListId) {
    // TODO: implement getGroceryListItems
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroceryListItem(GroceryListItemModel groceryListItem) {
    // TODO: implement updateGroceryListItem
    throw UnimplementedError();
  }
}
