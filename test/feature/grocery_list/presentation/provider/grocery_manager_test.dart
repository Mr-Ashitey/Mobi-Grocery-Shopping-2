import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helpers/reusable_mocks.dart';

void main() {
  late ReusableMocks reusableMocks;
  setUp(() {
    reusableMocks = ReusableMocks();
    reusableMocks.initGroceryManager();
  });

  const groceryList = GroceryListModel(
      groceryListId: 1,
      groceryListName: "groceryListName",
      groceryListItemsModel: []);
  const groceryList2 = GroceryListModel(
      groceryListId: 2,
      groceryListName: "groceryListName",
      groceryListItemsModel: []);
  const updateGroceryList =
      GroceryListModel(groceryListName: "updateGroceryListName");
  const listGroceryList = [groceryList, groceryList2];

  const groceryListItem = GroceryListItemModel(
      groceryListItemName: 'groceryListItemName', groceryListId: 1);
  group("Grocery Lists", () {
    group("success", () {
      test('getGroceryLists should get all grocery lists', () async {
        // arrange
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));

        // act
        await reusableMocks.groceryManager.getGroceryLists();

        // assert
        expect(
            reusableMocks.groceryManager.groceryLists, equals(listGroceryList));
        expect(
            reusableMocks.groceryManager.notifierState, NotifierState.loaded);
      });
      test('getGroceryList should get a grocery list', () async {
        // arrange (populate grocery lists)
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await reusableMocks.groceryManager.getGroceryLists();

        // act
        await reusableMocks.groceryManager.getGroceryList(groceryList.id!);

        // assert
        expect(reusableMocks.groceryManager.groceryList, equals(groceryList));
      });
      test('addGroceryList should add a grocery list', () async {
        when(reusableMocks.mockAddGroceryListUseCase.call(any))
            .thenAnswer((_) async => const Right(null));

        // act
        await reusableMocks.groceryManager.addGroceryList(groceryList);

        // assert
        expect(reusableMocks.groceryManager.groceryLists.length, 1);
        expect(reusableMocks.groceryManager.groceryLists.first,
            equals(groceryList));
        expect(
            reusableMocks.groceryManager.notifierState, NotifierState.loaded);
      });
      test('updateGroceryList should update a grocery list', () async {
        // populate grocery lists
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await reusableMocks.groceryManager.getGroceryLists();

        // arrange
        when(reusableMocks.mockUpdateGroceryListUseCase.call(any, any))
            .thenAnswer((_) async => const Right(null));

        // act
        await reusableMocks.groceryManager
            .updateGroceryList(groceryList.id!, updateGroceryList);

        // assert
        expect(reusableMocks.groceryManager.groceryLists.first,
            equals(updateGroceryList));
        expect(
            reusableMocks.groceryManager.notifierState, NotifierState.loaded);
      });
      test('deleteGroceryList should delete a grocery list', () async {
        // populate grocery lists
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await reusableMocks.groceryManager.getGroceryLists();

        // arrange
        when(reusableMocks.mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => const Right(null));
        expect(reusableMocks.groceryManager.groceryLists.length, 2);

        // act
        await reusableMocks.groceryManager.deleteGroceryList(groceryList.id!);

        // assert
        expect(reusableMocks.groceryManager.groceryLists.length, 1);
        expect(
            reusableMocks.groceryManager.notifierState, NotifierState.loaded);
      });
    });

    group("throws error", () {
      test('getGroceryLists should throw Failure', () async {
        // arrange
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.getGroceryLists;

        // assert
        // call();
        // expect(reusableMocks.groceryManager.errorMessage, equals("error"));
        expect(() async => await call(), throwsA(const TypeMatcher<Failure>()));
      });

      test('getGroceryList should throw Exception', () async {
        // act
        await reusableMocks.groceryManager.getGroceryList(groceryList.id!);
        // assert
        expect(reusableMocks.groceryManager.groceryList, isNull);
      });
      test('addGroceryList should throw a Failure', () async {
        // arrange (populate grocery lists)
        when(reusableMocks.mockAddGroceryListUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.addGroceryList;
        // assert
        expect(() async => await call(groceryList),
            throwsA(const TypeMatcher<Failure>()));
      });

      test('updateGroceryList should throw a Failure', () async {
        // arrange
        when(reusableMocks.mockUpdateGroceryListUseCase.call(any, any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.updateGroceryList;

        // assert
        expect(() async => await call(groceryList.id!, updateGroceryList),
            throwsA(const TypeMatcher<Failure>()));
      });

      test('deleteGroceryList should throw Failure', () async {
        // arrange
        when(reusableMocks.mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.deleteGroceryList;

        // assert
        expect(() async => await call(groceryList.id!),
            throwsA(const TypeMatcher<Failure>()));
      });
    });
  });

  group("Grocery List Items", () {
    group("success", () {
      setUp(() async {
        // populate grocery lists
        when(reusableMocks.mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await reusableMocks.groceryManager.getGroceryLists();
      });
      // test('addGroceryListItem should get add a grocery list item', () async {
      //   // arrange
      //   when(reusableMocks.mockAddGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await reusableMocks.groceryManager.addGroceryListItem(
      //       groceryList.id!, groceryListItem);

      //   // assert
      //   // expect(reusableMocks.groceryManager.groceryLists.first.groceryListItems,
      //   //     equals(groceryListItem));
      // });
      // test('deleteGroceryListItem should get update a grocery list item',
      //     () async {
      //   // arrange
      //   when(reusableMocks.mockDeleteGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await reusableMocks.groceryManager.deleteGroceryListItem(groceryListItem);

      //   // assert
      //   expect(reusableMocks.groceryManager.groceryLists.first.groceryListItems,
      //       equals(groceryListItem));
      // });
      // test('updateGroceryListItem should get update a grocery list item',
      //     () async {
      //   // arrange
      //   when(mockUpdateGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await reusableMocks.groceryManager.updateGroceryListItem(groceryListItem);

      //   // assert
      //   expect(reusableMocks.groceryManager.groceryLists.first.groceryListItems,
      //       equals(groceryListItem));
      // });
    });
    group("error", () {
      test('addGroceryListItem should throw error', () async {
        // arrange
        when(reusableMocks.mockAddGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.addGroceryListItem;

        // assert
        expect(() async => await call(groceryList.id!, groceryListItem),
            throwsA(const TypeMatcher<Failure>()));
      });
      test('deleteGroceryListItem should get update a grocery list item',
          () async {
        // arrange
        when(reusableMocks.mockDeleteGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.deleteGroceryListItem;

        // assert
        expect(() async => await call(groceryList.id!, groceryListItem.id),
            throwsA(const TypeMatcher<Failure>()));
      });
      test('updateGroceryListItem should throw error', () async {
        // arrange
        when(reusableMocks.mockUpdateGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = reusableMocks.groceryManager.updateGroceryListItem;

        // assert
        expect(() async => await call(groceryListItem),
            throwsA(const TypeMatcher<Failure>()));
      });
    });
  });

  const listGroceryListWithItems = [
    GroceryListModel(
        groceryListId: 1,
        groceryListName: "groceryListName",
        groceryListItemsModel: [groceryListItem]),
    GroceryListModel(
        groceryListId: 1,
        groceryListName: "groceryListName",
        groceryListItemsModel: [groceryListItem]),
  ];

  final expected = [
    listGroceryListWithItems.first.groceryListItemsModel.first,
    listGroceryListWithItems.last.groceryListItemsModel.first,
  ];
  test("getAllGroceryItems", () async {
    // populate grocery lists
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryListWithItems));
    await reusableMocks.groceryManager.getGroceryLists();

    // act
    final result = reusableMocks.groceryManager.getAllGroceryItems();

    // assert
    expect(result, equals(expected));
  });
}
