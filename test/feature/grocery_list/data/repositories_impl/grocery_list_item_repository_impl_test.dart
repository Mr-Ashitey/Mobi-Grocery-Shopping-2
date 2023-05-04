import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/repositories_impl/grocery_list_item_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'grocery_list_item_repository_impl_test.mocks.dart';

@GenerateMocks([GrcoeryListItemRemoteDataSource, NetworkInfo])
void main() {
  late GroceryListItemRepositoryImpl groceryListItemRepositoryImpl;
  late MockGrcoeryListItemRemoteDataSource mockGroceryListItemRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGroceryListItemRemoteDataSource = MockGrcoeryListItemRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groceryListItemRepositoryImpl = GroceryListItemRepositoryImpl(
        groceryListItemRemoteDataSource: mockGroceryListItemRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  const groceryListItemModel =
      GroceryListItemModel(groceryListItemId: 1, groceryListItemName: "Apple");
  const groceryListItems = [groceryListItemModel, groceryListItemModel];

  test('check if device is online', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGroceryListItemRemoteDataSource
            .deleteGroceryListItem(groceryListItemModel.id))
        .thenAnswer((_) async => groceryListItems);

    await groceryListItemRepositoryImpl
        .deleteGroceryListItem(groceryListItemModel.id);

    verify(mockNetworkInfo.isConnected);
  });

  group("Device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('no internet on add grocery lists', () async {
      final result = await groceryListItemRepositoryImpl
          .addGroceryListItem(groceryListItemModel);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
    test('no internet on delete grocery list', () async {
      final result = await groceryListItemRepositoryImpl
          .deleteGroceryListItem(groceryListItemModel.id);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
    test('no internet on update grocery list', () async {
      final result = await groceryListItemRepositoryImpl
          .updateGroceryListItem(groceryListItemModel);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
  });

  group('device is online', () {
    // AddGroceryListItem
    test(
        'should add grocery list item to remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .addGroceryListItem(groceryListItemModel))
          .thenAnswer((_) async => const Right(null));

      //act
      final result = await groceryListItemRepositoryImpl
          .addGroceryListItem(groceryListItemModel);

      //assert
      verify(mockGroceryListItemRemoteDataSource
          .addGroceryListItem(groceryListItemModel));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to add grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .addGroceryListItem(groceryListItemModel))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl
          .addGroceryListItem(groceryListItemModel);
      //assert
      verify(mockGroceryListItemRemoteDataSource
          .addGroceryListItem(groceryListItemModel));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // DeleteGroceryListItem
    test(
        'should delete a grocery list item from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .deleteGroceryListItem(groceryListItemModel.id))
          .thenAnswer((_) async => const Right(null));

      //act
      final result = await groceryListItemRepositoryImpl
          .deleteGroceryListItem(groceryListItemModel.id);

      //assert
      verify(mockGroceryListItemRemoteDataSource
          .deleteGroceryListItem(groceryListItemModel.id));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to delete grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .deleteGroceryListItem(groceryListItemModel.id))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl
          .deleteGroceryListItem(groceryListItemModel.id);
      //assert
      verify(mockGroceryListItemRemoteDataSource
          .deleteGroceryListItem(groceryListItemModel.id));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // UpdateGroceryList
    test(
        'should update a grocery list item from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .updateGroceryListItem(groceryListItemModel))
          .thenAnswer((_) async => groceryListItemModel);

      //act
      final result = await groceryListItemRepositoryImpl
          .updateGroceryListItem(groceryListItemModel);

      //assert
      verify(mockGroceryListItemRemoteDataSource
          .updateGroceryListItem(groceryListItemModel));
      // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to update a grocery list item on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListItemRemoteDataSource
              .updateGroceryListItem(groceryListItemModel))
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListItemRepositoryImpl
          .updateGroceryListItem(groceryListItemModel);
      //assert
      verify(mockGroceryListItemRemoteDataSource
          .updateGroceryListItem(groceryListItemModel));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });
  });
}
