import '../../model/grocery_list_model.dart';

abstract class GrcoeryListRemoteDataSource {
  Future<List<GroceryListModel>> getGroceryLists();

  Future<GroceryListModel> getGroceryList(int id);

  Future<void> addGroceryList(GroceryListModel groceryList);

  Future<void> updateGroceryList(GroceryListModel groceryList);

  Future<void> deleteGroceryList(int id);
}

class GrcoeryListRemoteDataSourceImpl implements GrcoeryListRemoteDataSource {
  @override
  Future<void> addGroceryList(GroceryListModel groceryList) {
    // TODO: implement addGroceryList
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGroceryList(int id) {
    // TODO: implement deleteGroceryList
    throw UnimplementedError();
  }

  @override
  Future<GroceryListModel> getGroceryList(int id) {
    // TODO: implement getGroceryList
    throw UnimplementedError();
  }

  @override
  Future<List<GroceryListModel>> getGroceryLists() {
    // TODO: implement getGroceryLists
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroceryList(GroceryListModel groceryList) {
    // TODO: implement updateGroceryList
    throw UnimplementedError();
  }
}
