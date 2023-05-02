import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_datasource/grocery_list_item_local_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_datasource/grocery_list_item_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/repositories_impl/grocery_list_item_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'grocery_list_item_repository_impl_test.mocks.dart';

@GenerateMocks([
  GrcoeryListItemLocalDataSource,
  GrcoeryListItemRemoteDataSource,
  NetworkInfo
])
void main() {
  late GroceryListItemRepositoryImpl groceryListItemRepositoryImpl;
  late MockGrcoeryListItemLocalDataSource mockGroceryListItemLocalDataSource;
  late MockGrcoeryListItemRemoteDataSource mockGroceryListItemRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGroceryListItemLocalDataSource = MockGrcoeryListItemLocalDataSource();
    mockGroceryListItemRemoteDataSource = MockGrcoeryListItemRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groceryListItemRepositoryImpl = GroceryListItemRepositoryImpl(
        groceryListItemLocalDataSource: mockGroceryListItemLocalDataSource,
        groceryListItemRemoteDataSource: mockGroceryListItemRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  const groceryListId = 1;
  const groceryListItemModel =
      GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple");
  const groceryListItems = [groceryListItemModel, groceryListItemModel];
// // Create a mock GroceryListModel.
//   const groceryListItems = [
//     GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple"),
//     GroceryListItemModel(groceryListItemId: 2, groceryListItemName: "Banana"),
//     GroceryListItemModel(groceryListItemId: 3, groceryListItemName: "Orange")
//   ];

  test('check if device is online', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGroceryListItemRemoteDataSource.getGroceryListItems(groceryListId))
        .thenAnswer((_) async => groceryListItems);

    await groceryListItemRepositoryImpl.getGroceryListItems(groceryListId);

    verify(mockNetworkInfo.isConnected);
  });

  group('device is online', () {
    // AddGroceryListItem
    test(
        'should add grocery list item to remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.addGroceryListItem(
              groceryListId, groceryListItemModel))
          .thenAnswer((_) async => const Right(null));
      when(mockGroceryListItemLocalDataSource.addGroceryListItem(
              groceryListId, groceryListItemModel))
          .thenAnswer((_) async => const Right(null));

      //act
      final result = await groceryListItemRepositoryImpl.addGroceryListItem(
          groceryListId, groceryListItemModel);

      //assert
      verify(mockGroceryListItemRemoteDataSource.addGroceryListItem(
          groceryListId, groceryListItemModel));
      verify(mockGroceryListItemLocalDataSource.addGroceryListItem(
          groceryListId, groceryListItemModel));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to add grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.addGroceryListItem(
              groceryListId, groceryListItemModel))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl.addGroceryListItem(
          groceryListId, groceryListItemModel);
      //assert
      verify(mockGroceryListItemRemoteDataSource.addGroceryListItem(
          groceryListId, groceryListItemModel));
      verifyZeroInteractions(mockGroceryListItemLocalDataSource);
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // DeleteGroceryListItem
    test(
        'should delete a grocery list item from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.deleteGroceryListItem(
              groceryListId, groceryListItemModel.id))
          .thenAnswer((_) async => const Right(null));
      when(mockGroceryListItemLocalDataSource.deleteGroceryListItem(
              groceryListId, groceryListItemModel.id))
          .thenAnswer((_) async => const Right(null));

      //act
      final result = await groceryListItemRepositoryImpl.deleteGroceryListItem(
          groceryListId, groceryListItemModel.id);

      //assert
      verify(mockGroceryListItemRemoteDataSource.deleteGroceryListItem(
          groceryListId, groceryListItemModel.id));
      verify(mockGroceryListItemLocalDataSource.deleteGroceryListItem(
          groceryListId, groceryListItemModel.id));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to delete grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.deleteGroceryListItem(
              groceryListId, groceryListItemModel.id))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl.deleteGroceryListItem(
          groceryListId, groceryListItemModel.id);
      //assert
      verify(mockGroceryListItemRemoteDataSource.deleteGroceryListItem(
          groceryListId, groceryListItemModel.id));
      verifyZeroInteractions(mockGroceryListItemLocalDataSource);
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // GetGroceryListItem
    test(
        'should get a grocery list item from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.getGroceryListItem(
              groceryListId, groceryListItemModel.id))
          .thenAnswer((_) async => groceryListItemModel);
      // when(mockGroceryListLocalDataSource.getGroceryList(groceryListId))
      //     .thenAnswer((_) async => groceryListModel);

      //act
      final result = await groceryListItemRepositoryImpl.getGroceryListItem(
          groceryListId, groceryListItemModel.id);

      //assert
      verify(mockGroceryListItemRemoteDataSource.getGroceryListItem(
          groceryListId, groceryListItemModel.id));
      // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
      expect(result, const Right(groceryListItemModel));
    });

    test(
        'should return Failure when call to get grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.getGroceryListItem(
              groceryListId, groceryListItemModel.id))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl.getGroceryListItem(
          groceryListId, groceryListItemModel.id);
      //assert
      verify(mockGroceryListItemRemoteDataSource.getGroceryListItem(
          groceryListId, groceryListItemModel.id));
      verifyZeroInteractions(mockGroceryListItemLocalDataSource);
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // GetGroceryListItems
    test(
        'should get grocery list items from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .getGroceryListItems(groceryListId))
          .thenAnswer((_) async => groceryListItems);
      // when(mockGroceryListLocalDataSource.getGroceryList(groceryListId))
      //     .thenAnswer((_) async => groceryListModel);

      //act
      final result = await groceryListItemRepositoryImpl
          .getGroceryListItems(groceryListId);

      //assert
      verify(mockGroceryListItemRemoteDataSource
          .getGroceryListItems(groceryListId));
      // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
      expect(result, const Right(groceryListItems));
    });

    test(
        'should return Failure when call to get grocery list items on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .getGroceryListItems(groceryListId))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl
          .getGroceryListItems(groceryListId);
      //assert
      verify(mockGroceryListItemRemoteDataSource
          .getGroceryListItems(groceryListId));
      // verifyZeroInteractions(mockGroceryListItemLocalDataSource
      //     .getGroceryListItems(groceryListId));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });
    // });

    // UpdateGroceryList
    test(
        'should update a grocery list item from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.updateGroceryListItem(
              groceryListId, groceryListItemModel.id, groceryListItemModel))
          .thenAnswer((_) async => groceryListItemModel);
      when(mockGroceryListItemLocalDataSource.updateGroceryListItem(
              groceryListId, groceryListItemModel.id, groceryListItemModel))
          .thenAnswer((_) async => groceryListItemModel);

      //act
      final result = await groceryListItemRepositoryImpl.updateGroceryListItem(
          groceryListId, groceryListItemModel.id, groceryListItemModel);

      //assert
      verify(mockGroceryListItemRemoteDataSource.updateGroceryListItem(
          groceryListId, groceryListItemModel.id, groceryListItemModel));
      // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to update a grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource.updateGroceryListItem(
              groceryListId, groceryListItemModel.id, groceryListItemModel))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl.updateGroceryListItem(
          groceryListId, groceryListItemModel.id, groceryListItemModel);
      //assert
      verify(mockGroceryListItemRemoteDataSource.updateGroceryListItem(
          groceryListId, groceryListItemModel.id, groceryListItemModel));
      verifyZeroInteractions(mockGroceryListItemLocalDataSource);
      expect(result.fold((l) => l.message, (r) => null), "error");
    });
  });
}
