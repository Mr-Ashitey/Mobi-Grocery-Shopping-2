import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/repositories_impl/grocery_list_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helpers/reusable_mocks.mocks.dart';

void main() {
  late GroceryListRepositoryImpl groceryListRepositoryImpl;
  late MockGroceryListRemoteDataSource mockGroceryListRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGroceryListRemoteDataSource = MockGroceryListRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    groceryListRepositoryImpl = GroceryListRepositoryImpl(
        groceryListRemoteDataSource: mockGroceryListRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  const groceryListId = 1;
  const groceryListModel =
      GroceryListModel(groceryListId: 1, groceryListName: 'List 1');
  const groceryLists = [groceryListModel, groceryListModel];

  test('check if device is online', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGroceryListRemoteDataSource.getGroceryLists())
        .thenAnswer((_) async => groceryLists);

    await groceryListRepositoryImpl.getGroceryLists();

    verify(mockNetworkInfo.isConnected);
  });

  group("Device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test('no internet on add grocery lists', () async {
      final result =
          await groceryListRepositoryImpl.addGroceryList(groceryListModel);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
    test('no internet on delete grocery list', () async {
      final result =
          await groceryListRepositoryImpl.deleteGroceryList(groceryListId);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
    test('no internet on get grocery lists', () async {
      final result = await groceryListRepositoryImpl.getGroceryLists();

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
    test('no internet on update grocery list', () async {
      final result = await groceryListRepositoryImpl.updateGroceryList(
          groceryListId, groceryListModel);

      expect(result.fold((l) => l.message, (r) => null), 'No Internet');
    });
  });

  group('device is online', () {
    // runTestsOnline(() {
    // AddGroceryList
    test(
        'should add grocery list to remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.addGroceryList(groceryListModel))
          .thenAnswer((_) async => const Right(null));

      //act
      final result =
          await groceryListRepositoryImpl.addGroceryList(groceryListModel);

      //assert
      verify(mockGroceryListRemoteDataSource.addGroceryList(groceryListModel));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to add grocery list on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.addGroceryList(groceryListModel))
          .thenThrow(Failure('error'));
      //act
      final result =
          await groceryListRepositoryImpl.addGroceryList(groceryListModel);
      //assert
      verify(mockGroceryListRemoteDataSource.addGroceryList(groceryListModel));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // DeleteGroceryList
    test(
        'should delete a grocery list from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.deleteGroceryList(groceryListId))
          .thenAnswer((_) async => const Right(null));

      //act
      final result =
          await groceryListRepositoryImpl.deleteGroceryList(groceryListId);

      //assert
      verify(mockGroceryListRemoteDataSource.deleteGroceryList(groceryListId));
      expect(result, const Right(null));
    });

    test(
        'should return Failure when call to delete grocery list on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.deleteGroceryList(groceryListId))
          .thenThrow(Failure('error'));
      //act
      final result =
          await groceryListRepositoryImpl.deleteGroceryList(groceryListId);
      //assert
      verify(mockGroceryListRemoteDataSource.deleteGroceryList(groceryListId));
      expect(result.fold((l) => l.message, (r) => null), "error");
    });

    // GetGroceryLists
    test(
        'should get grocery lists from remote and local data sources when call to remote data source is successful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.getGroceryLists())
          .thenAnswer((_) async => groceryLists);
      // when(mockGroceryListLocalDataSource.getGroceryList(groceryListId))
      //     .thenAnswer((_) async => groceryListModel);

      //act
      final result = await groceryListRepositoryImpl.getGroceryLists();

      //assert
      verify(mockGroceryListRemoteDataSource.getGroceryLists());
      // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
      expect(result, const Right(groceryLists));
    });

    test(
        'should return Failure when call to get grocery lists on remote data source is unsuccessful',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGroceryListRemoteDataSource.getGroceryLists())
          .thenThrow(Failure('error'));
      //act
      final result = await groceryListRepositoryImpl.getGroceryLists();
      //assert
      verify(mockGroceryListRemoteDataSource.getGroceryLists());
      expect(result.fold((l) => l.message, (r) => null), "error");
    });
  });

  // UpdateGroceryList
  test(
      'should update a grocery list from remote and local data sources when call to remote data source is successful',
      () async {
    //arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGroceryListRemoteDataSource.updateGroceryList(
            groceryListId, groceryListModel))
        .thenAnswer((_) async => groceryListModel);

    //act
    final result = await groceryListRepositoryImpl.updateGroceryList(
        groceryListId, groceryListModel);

    //assert
    verify(mockGroceryListRemoteDataSource.updateGroceryList(
        groceryListId, groceryListModel));
    // verify(mockGroceryListLocalDataSource.getGroceryList(groceryListId));
    expect(result, const Right(null));
  });

  test(
      'should return Failure when call to get grocery lists on remote data source is unsuccessful',
      () async {
    //arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGroceryListRemoteDataSource.updateGroceryList(
            groceryListId, groceryListModel))
        .thenThrow(Failure('error'));
    //act
    final result = await groceryListRepositoryImpl.updateGroceryList(
        groceryListId, groceryListModel);
    //assert
    verify(mockGroceryListRemoteDataSource.updateGroceryList(
        groceryListId, groceryListModel));
    expect(result.fold((l) => l.message, (r) => null), "error");
  });
}
