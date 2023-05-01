import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_datasource/grocery_list_item_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../grocery_list_datasource/grocery_list_remote_datasource_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late GrcoeryListItemRemoteDataSourceImpl dataSourceImpl;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSourceImpl = GrcoeryListItemRemoteDataSourceImpl(mockDioClient);
  });

  const groceryListId = 1;
  const groceryListItem =
      GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple");
// Create a mock GroceryListModel.
  const groceryListItems = [
    GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple"),
    GroceryListItemModel(groceryListItemId: 2, groceryListItemName: "Banana"),
    GroceryListItemModel(groceryListItemId: 3, groceryListItemName: "Orange")
  ];

  final successResponse = Response(
    requestOptions: RequestOptions(),
    data: groceryListItem.toJson(),
    // "{'id': 1,'name': 'Grocery List','groceryListItems': '[{'id': 1, 'name': 'Apple'}, {'id': 2, 'name': 'Banana'},{'id': 3, 'name': 'Orange'})]}",
    statusCode: 200,
  );
  final successResponse2 = Response(
    statusCode: 200,
    data: groceryListItems.map((list) => list.toJson()).toList(),
    requestOptions: RequestOptions(),
  );
  final emptyResponse = Response(requestOptions: RequestOptions());

  group('GrcoeryListItemRemoteDataSourceImpl success', () {
    test(
      'should add GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange

        when(mockDioClient.post(any, groceryListItem.toJson()))
            .thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.addGroceryListItem(groceryListId, groceryListItem);

        // assert
        verify(mockDioClient.post(any, groceryListItem.toJson()));
      },
    );
    test(
      'should delete GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange

        when(mockDioClient.delete(any)).thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.deleteGroceryListItem(
            groceryListId, groceryListItem.id);
        // assert
        verify(mockDioClient.delete(any));
      },
    );
    test(
      'should get a single GroceryListModel when the response code is 200 (success)',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenAnswer((_) async => successResponse);

        // act
        final result = await dataSourceImpl.getGroceryListItem(
            groceryListId, groceryListItem.id);
        // assert
        expect(result, equals(groceryListItem));
      },
    );
    test(
      'should get a List<GroceryListModel> when the response code is 200 (success)',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenAnswer((_) async => successResponse2);

        // act
        final result = await dataSourceImpl.getGroceryListItems(groceryListId);
        // assert
        expect(result, equals(groceryListItems));
      },
    );
    test(
      'should update a GroceryListItemModel when the response code is 200 (success)',
      () async {
        // arrange
        when(mockDioClient.put(any, groceryListItem.toJson()))
            .thenAnswer((_) async => emptyResponse);

        // act
        await dataSourceImpl.updateGroceryListItem(
            groceryListId, groceryListItem);
        // assert
        verify(mockDioClient.put(any, groceryListItem.toJson()));
      },
    );
  });

  group('GrcoeryListItemRemoteDataSourceImpl failure', () {
    test(
      'should throw a Failure on adding a GroceryListModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.post(any, groceryListItem.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.addGroceryListItem(groceryListId, groceryListItem),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on deleting a GroceryListItemModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.delete(any)).thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.deleteGroceryListItem(
                groceryListId, groceryListItem.id),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on adding a GroceryListItemModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.post(any, groceryListItem.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.addGroceryListItem(groceryListId, groceryListItem),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on getting a single GroceryListItemModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.getGroceryListItem(
                groceryListId, groceryListItem.id),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on getting a List<GroceryListItemModel> when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.get(any)).thenThrow(Failure("Not Found"));

        // assert
        expect(dataSourceImpl.getGroceryListItems(groceryListId),
            throwsA(isInstanceOf<Failure>()));
      },
    );
    test(
      'should throw a Failure on updating a GroceryListItemModel when the response code is 404 or other',
      () async {
        // arrange
        when(mockDioClient.put(any, groceryListItem.toJson()))
            .thenThrow(Failure("Not Found"));

        // assert
        expect(
            dataSourceImpl.updateGroceryListItem(
                groceryListId, groceryListItem),
            throwsA(isInstanceOf<Failure>()));
      },
    );
  });
}
