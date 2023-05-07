import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/config/route_path.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_item_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/grocery_list_detail_page/grocery_list_detail.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/components/dialog_component/manage_grocery_list_dialog.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/components/grocery_list_card.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/home_screen.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/reusable_mocks.dart';

void main() {
  late ReusableMocks reusableMocks;
  setUp(() {
    reusableMocks = ReusableMocks();
    reusableMocks.initGroceryManager();
  });

  const groceryList = GroceryListModel(
      groceryListId: 1,
      groceryListName: "groceryListName",
      groceryListItemsModel: [
        GroceryListItemModel(groceryListItemName: "item"),
        GroceryListItemModel(
            groceryListItemName: "item2", groceryListItemIsCollected: true),
      ]);
  const groceryList2 = GroceryListModel(
      groceryListId: 2,
      groceryListName: "groceryListName2",
      groceryListItemsModel: [
        GroceryListItemModel(groceryListItemName: "item"),
        GroceryListItemModel(
            groceryListItemName: "item2", groceryListItemIsCollected: true),
      ]);
  const listGroceryList = [groceryList, groceryList2];
  const listGroceryList2 = [
    groceryList,
    groceryList2,
    groceryList,
    groceryList2
  ];

  testWidgets('displays screen placeholder when groceryLists is empty',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(<GroceryListModel>[]));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    expect(find.text('Start Shopping...'), findsOneWidget);
  });

  testWidgets('displays grocery lists when groceryLists is not empty',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    expect(find.byType(GroceryListCard), findsNWidgets(2));
  });
  testWidgets('show error when we get an error trying to get grocery lists',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => Left(Failure("error")));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(
        find.text("error"),
        findsNWidgets(
            2)); // two error messages because one will show on screen and the other of snackbar
  });
  testWidgets('when grocery list is tapped, navigate to detail screen',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    await tester.tap(find.byType(GroceryListCard).first);
    await tester.pumpAndSettle();

    expect(find.byType(ViewGroceryListScreen), findsOneWidget);
  });

  group('More/Options button on grocery list', () {
    final renameGroceryListBtn = find.byKey(const Key('rename_grocery_list'));
    final deleteGroceryListBtn = find.byKey(const Key('delete_grocery_list'));
    final groceryListNameTextField = find.byType(TextField);
    setUp(() {
      when(reusableMocks.mockGetGroceryListsUseCase.call())
          .thenAnswer((_) async => const Right(listGroceryList));
    });
    testWidgets('brings up bottom sheet modal', (WidgetTester tester) async {
      await tester.pumpApp(
          RoutePath.homeRoutePath, reusableMocks.groceryManager);
      await tester.pump(Duration.zero);

      // tap on more on the first grocery list
      await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
      await tester.pump();

      expect(renameGroceryListBtn, findsOneWidget);
      expect(deleteGroceryListBtn, findsOneWidget);
      expect(find.byType(ManageGroceryList), findsOneWidget);
    });
    testWidgets('brings up bottom sheet modal and rename button works',
        (WidgetTester tester) async {
      // create a mock list tile
      when(reusableMocks.mockUpdateGroceryListUseCase.call(any, any))
          .thenAnswer((_) async => const Right(null));
      await tester.pumpApp(
          RoutePath.homeRoutePath, reusableMocks.groceryManager);
      await tester.pump(Duration.zero);

      // tap on more on a grocery list
      await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
      await tester.pumpAndSettle();

      await tester.enterText(groceryListNameTextField, "Rename Grocery List");
      await tester.tap(renameGroceryListBtn);
      await tester.pump();

      expect(find.text("Rename Grocery List"), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
    testWidgets('brings up bottom sheet modal and rename throws an error',
        (WidgetTester tester) async {
      // create a mock list tile
      when(reusableMocks.mockUpdateGroceryListUseCase.call(any, any))
          .thenAnswer((_) async => Left(Failure("error")));
      await tester.pumpApp(
          RoutePath.homeRoutePath, reusableMocks.groceryManager);
      await tester.pump(Duration.zero);

      // tap on more on a grocery list
      await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
      await tester.pumpAndSettle();

      await tester.enterText(groceryListNameTextField, "Rename Grocery List");
      await tester.tap(renameGroceryListBtn);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text("error"), findsOneWidget);
    });

    group("Delete Brings Up Dialog", () {
      setUp(() {
        when(reusableMocks.mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => const Right(null));
      });
      testWidgets('and tap yes deletes the grocery list',
          (WidgetTester tester) async {
        // create a mock list tile
        await tester.pumpApp(
            RoutePath.homeRoutePath, reusableMocks.groceryManager);
        await tester.pump(Duration.zero);

        // initial grocery list exists
        expect(find.byType(GroceryListCard), findsNWidgets(2));

        // tap on more on the first grocery list
        await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
        await tester.pumpAndSettle();

        await tester.tap(deleteGroceryListBtn);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
        expect(find.text('No'), findsOneWidget);

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(deleteGroceryListBtn, findsNothing);
        expect(find.text(listGroceryList.last.groceryListName), findsNothing);
        expect(find.byType(HomeScreen), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets(
          'and tap no stops deletion process and returns to bottom sheet',
          (WidgetTester tester) async {
        // create a mock list tile
        await tester.pumpApp(
            RoutePath.homeRoutePath, reusableMocks.groceryManager);
        await tester.pump(Duration.zero);

        // initial grocery list exists
        expect(find.byType(GroceryListCard), findsNWidgets(2));

        // tap on more on the first grocery list
        await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
        await tester.pumpAndSettle();

        await tester.tap(deleteGroceryListBtn);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
        expect(find.text('No'), findsOneWidget);

        await tester.tap(find.text('No'));
        await tester.pump();

        expect(deleteGroceryListBtn, findsOneWidget);
        expect(find.byType(ManageGroceryList), findsOneWidget);
        expect(find.byType(HomeScreen), findsOneWidget);
      });

      testWidgets('throw an error when try to delete a grocery list',
          (WidgetTester tester) async {
        when(reusableMocks.mockDeleteGroceryListUseCase.call(any))
            .thenAnswer((_) async => Left(Failure("error")));
        // create a mock list tile
        await tester.pumpApp(
            RoutePath.homeRoutePath, reusableMocks.groceryManager);
        await tester.pump(Duration.zero);

        // tap on more on the first grocery list
        await tester.tap(find.byIcon(Icons.more_vert_rounded).first);
        await tester.pumpAndSettle();

        await tester.tap(deleteGroceryListBtn);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text("error"), findsOneWidget);
      });
    });
  });
  testWidgets('displays add new list dialog when FAB is pressed',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('New Grocery List'), findsOneWidget);
    expect(find.text('Add New List'), findsOneWidget);
  });
  testWidgets('add new list and navigate to home screen',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));
    when(reusableMocks.mockAddGroceryListUseCase.call(any))
        .thenAnswer((_) async => const Right(null));
    final newListTextField = find.byType(TextField);

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(newListTextField, "New List");
    await tester.tap(find.byKey(const Key('add_new_list_btn')));
    await tester.pump();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(GroceryListCard), findsNWidgets(3));
  });
  testWidgets('add new list throws error', (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));
    when(reusableMocks.mockAddGroceryListUseCase.call(any))
        .thenAnswer((_) async => Left(Failure("error")));
    final newListTextField = find.byType(TextField);

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(newListTextField, "New List");
    await tester.tap(find.byKey(const Key('add_new_list_btn')));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text("error"), findsOneWidget);
  });

  testWidgets('Refresh icon refetches grocery lists',
      (WidgetTester tester) async {
    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList));

    await tester.pumpApp(RoutePath.homeRoutePath, reusableMocks.groceryManager);
    await tester.pump(Duration.zero);

    // expect 2 grocery list on init
    expect(find.byType(GroceryListCard), findsNWidgets(2));

    when(reusableMocks.mockGetGroceryListsUseCase.call())
        .thenAnswer((_) async => const Right(listGroceryList2));
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump(Duration.zero);

    // expect 4 grocery list after refreshing (here we simulate an instance where more grocery lists have been added but we don't have it showing yet)
    expect(find.byType(GroceryListCard), findsNWidgets(4));
  });
}
