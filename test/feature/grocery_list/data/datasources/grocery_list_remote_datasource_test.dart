import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helpers/reusable_mocks.mocks.dart';

void main() {
  late GrcoeryListRemoteDataSourceImpl dataSourceImpl;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSourceImpl = GrcoeryListRemoteDataSourceImpl(mockDioClient);
  });

// Create a mock GroceryListModel.
  const groceryListModel = GroceryListModel(
    groceryListId: 1,
    groceryListName: 'Grocery List',
    groceryListItemsModel: [
      GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple"),
      GroceryListItemModel(groceryListItemId: 2, groceryListItemName: "Banana"),
      GroceryListItemModel(groceryListItemId: 3, groceryListItemName: "Orange")
    ],
  );
  const groceryListModel2 = GroceryListModel(
    groceryListId: 1,
    groceryListName: 'Grocery List 2',
    groceryListItemsModel: [
      GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple2"),
      GroceryListItemModel(
          groceryListItemId: 2, groceryListItemName: "Banana2"),
      GroceryListItemModel(groceryListItemId: 3, groceryListItemName: "Orange2")
    ],
  );
  final groceryListModelList = [groceryListModel, groceryListModel2];

  final successResponse2 = Response(
    statusCode: 200,
    data: groceryListModelList
        .map((list) => <String, dynamic>{
              'id': list.id,
              'name': list.groceryListName,
              'grocery_list_item': (list.groceryListItemsModel)
                  .map((e) => <String, dynamic>{
                        "id": e.id,
                        "name": e.name,
                        "collected": e.isCollected
                      })
                  .toList()
            })
        .toList(),
    requestOptions: RequestOptions(),
  );
  final emptyResponse = Response(requestOptions: RequestOptions());

  group('GrcoeryListRemoteDataSourceImpl success', () {
    test(
      'should add GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange

        when(mockDioClient.post(any, groceryListModel.toJson()))
            .thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.addGroceryList(groceryListModel);

        // assert
        verify(mockDioClient.post(any, groceryListModel.toJson()));
      },
    );
    test(
      'should delete GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange

        when(mockDioClient.delete(any)).thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.deleteGroceryList(groceryListModel.id!);
        // assert
        verify(mockDioClient.delete(any));
      },
    );
    test(
      'should get a List<GroceryListModel> when the response code is 200 (success)',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenAnswer((_) async => successResponse2);

        // act
        final result = await dataSourceImpl.getGroceryLists();
        // assert
        expect(result, equals(groceryListModelList));
      },
    );
    test(
      'should update a GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange
        when(mockDioClient.patch(any, groceryListModel.toJson()))
            .thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.updateGroceryList(
            groceryListModel.id!, groceryListModel);
        // assert
        verify(mockDioClient.patch(any, groceryListModel.toJson()));
      },
    );
  });

  group('GrcoeryListRemoteDataSourceImpl failure', () {
    test(
      'should throw a Failure on adding a GroceryListModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.post(any, groceryListModel.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(dataSourceImpl.addGroceryList(groceryListModel),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on deleting a GroceryListModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.delete(any)).thenThrow(Failure("Not Found"));

        // assert
        expect(dataSourceImpl.deleteGroceryList(groceryListModel.id!),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on adding a GroceryListModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.post(any, groceryListModel.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(dataSourceImpl.addGroceryList(groceryListModel),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on getting a List<GroceryListModel> when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.getGroceryLists(), throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on updating a GroceryListModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.patch(any, groceryListModel.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.updateGroceryList(
                groceryListModel.id!, groceryListModel),
            throwsA(isInstanceOf<Failure>()));
      },
    );
  });
}
