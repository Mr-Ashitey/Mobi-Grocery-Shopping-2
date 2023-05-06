import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/add_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/delete_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/update_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/add_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/delete_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/get_grocery_lists_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/update_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'grocery_manager_test.mocks.dart';

@GenerateMocks([
  GetGroceryListsUseCase,
  AddGroceryListUseCase,
  UpdateGroceryListUseCase,
  DeleteGroceryListUseCase,
  AddGroceryListItemUseCase,
  UpdateGroceryListItemUseCase,
  DeleteGroceryListItemUseCase
])
void main() {
  late MockGetGroceryListsUseCase mockGetGroceryListsUseCase;
  late MockAddGroceryListUseCase mockAddGroceryListUseCase;
  late MockUpdateGroceryListUseCase mockUpdateGroceryListUseCase;
  late MockDeleteGroceryListUseCase mockDeleteGroceryListUseCase;
  late MockAddGroceryListItemUseCase mockAddGroceryListItemUseCase;
  late MockUpdateGroceryListItemUseCase mockUpdateGroceryListItemUseCase;
  late MockDeleteGroceryListItemUseCase mockDeleteGroceryListItemUseCase;
  late GroceryManager groceryManager;

  setUp(() {
    mockGetGroceryListsUseCase = MockGetGroceryListsUseCase();
    mockAddGroceryListUseCase = MockAddGroceryListUseCase();
    mockUpdateGroceryListUseCase = MockUpdateGroceryListUseCase();
    mockDeleteGroceryListUseCase = MockDeleteGroceryListUseCase();
    mockAddGroceryListItemUseCase = MockAddGroceryListItemUseCase();
    mockUpdateGroceryListItemUseCase = MockUpdateGroceryListItemUseCase();
    mockDeleteGroceryListItemUseCase = MockDeleteGroceryListItemUseCase();
    groceryManager = GroceryManager(
        mockGetGroceryListsUseCase,
        mockAddGroceryListUseCase,
        mockUpdateGroceryListUseCase,
        mockDeleteGroceryListUseCase,
        mockUpdateGroceryListItemUseCase,
        mockAddGroceryListItemUseCase,
        mockDeleteGroceryListItemUseCase);
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
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));

        // act
        await groceryManager.getGroceryLists();

        // assert
        expect(groceryManager.groceryLists, equals(listGroceryList));
        expect(groceryManager.notifierState, NotifierState.loaded);
      });
      test('getGroceryList should get a grocery list', () async {
        // arrange (populate grocery lists)
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await groceryManager.getGroceryLists();

        // act
        await groceryManager.getGroceryList(groceryList.id!);

        // assert
        expect(groceryManager.groceryList, equals(groceryList));
      });
      test('addGroceryList should add a grocery list', () async {
        when(mockAddGroceryListUseCase.call(any))
            .thenAnswer((_) async => const Right(null));

        // act
        await groceryManager.addGroceryList(groceryList);

        // assert
        expect(groceryManager.groceryLists.length, 1);
        expect(groceryManager.groceryLists.first, equals(groceryList));
        expect(groceryManager.notifierState, NotifierState.loaded);
      });
      test('updateGroceryList should update a grocery list', () async {
        // populate grocery lists
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await groceryManager.getGroceryLists();

        // arrange
        when(mockUpdateGroceryListUseCase.call(any, any))
            .thenAnswer((_) async => const Right(null));

        // act
        await groceryManager.updateGroceryList(
            groceryList.id!, updateGroceryList);

        // assert
        expect(groceryManager.groceryLists.first, equals(updateGroceryList));
        expect(groceryManager.notifierState, NotifierState.loaded);
      });
      test('deleteGroceryList should delete a grocery list', () async {
        // populate grocery lists
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await groceryManager.getGroceryLists();

        // arrange
        when(mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => const Right(null));
        expect(groceryManager.groceryLists.length, 2);

        // act
        await groceryManager.deleteGroceryList(groceryList.id!);

        // assert
        expect(groceryManager.groceryLists.length, 1);
        expect(groceryManager.notifierState, NotifierState.loaded);
      });
    });

    group("throws error", () {
      test('getGroceryLists should throw Failure', () async {
        // arrange
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.getGroceryLists;

        // assert
        // call();
        // expect(groceryManager.errorMessage, equals("error"));
        expect(() async => await call(), throwsA(const TypeMatcher<Failure>()));
      });

      test('getGroceryList should throw Exception', () async {
        // act
        await groceryManager.getGroceryList(groceryList.id!);
        // assert
        expect(groceryManager.groceryList, isNull);
      });
      test('addGroceryList should throw a Failure', () async {
        // arrange (populate grocery lists)
        when(mockAddGroceryListUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.addGroceryList;
        // assert
        expect(() async => await call(groceryList),
            throwsA(const TypeMatcher<Failure>()));
      });

      test('updateGroceryList should throw a Failure', () async {
        // arrange
        when(mockUpdateGroceryListUseCase.call(any, any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.updateGroceryList;

        // assert
        expect(() async => await call(groceryList.id!, updateGroceryList),
            throwsA(const TypeMatcher<Failure>()));
      });

      test('deleteGroceryList should throw Failure', () async {
        // arrange
        when(mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.deleteGroceryList;

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
        when(mockGetGroceryListsUseCase.call())
            .thenAnswer((_) async => const Right(listGroceryList));
        await groceryManager.getGroceryLists();
      });
      // test('addGroceryListItem should get add a grocery list item', () async {
      //   // arrange
      //   when(mockAddGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await groceryManager.addGroceryListItem(
      //       groceryList.id!, groceryListItem);

      //   // assert
      //   // expect(groceryManager.groceryLists.first.groceryListItems,
      //   //     equals(groceryListItem));
      // });
      // test('deleteGroceryListItem should get update a grocery list item',
      //     () async {
      //   // arrange
      //   when(mockDeleteGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await groceryManager.deleteGroceryListItem(groceryListItem);

      //   // assert
      //   expect(groceryManager.groceryLists.first.groceryListItems,
      //       equals(groceryListItem));
      // });
      // test('updateGroceryListItem should get update a grocery list item',
      //     () async {
      //   // arrange
      //   when(mockUpdateGroceryListItemUseCase.call(any))
      //       .thenAnswer((_) async => const Right(null));

      //   // act
      //   await groceryManager.updateGroceryListItem(groceryListItem);

      //   // assert
      //   expect(groceryManager.groceryLists.first.groceryListItems,
      //       equals(groceryListItem));
      // });
    });
    group("error", () {
      test('addGroceryListItem should throw error', () async {
        // arrange
        when(mockAddGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.addGroceryListItem;

        // assert
        expect(() async => await call(groceryList.id!, groceryListItem),
            throwsA(const TypeMatcher<Failure>()));
      });
      test('deleteGroceryListItem should get update a grocery list item',
          () async {
        // arrange
        when(mockDeleteGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.deleteGroceryListItem;

        // assert
        expect(() async => await call(groceryList.id!, groceryListItem.id),
            throwsA(const TypeMatcher<Failure>()));
      });
      test('updateGroceryListItem should throw error', () async {
        // arrange
        when(mockUpdateGroceryListItemUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));

        // act
        final call = groceryManager.updateGroceryListItem;

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
    when(mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryListWithItems));
    await groceryManager.getGroceryLists();

    // act
    final result = groceryManager.getAllGroceryItems();

    // assert
    expect(result, equals(expected));
  });
}
