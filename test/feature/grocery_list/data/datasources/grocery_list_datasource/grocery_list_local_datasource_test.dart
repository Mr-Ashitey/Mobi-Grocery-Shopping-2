import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/error/failure.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_datasource/grocery_list_local_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'grocery_list_local_datasource_test.mocks.dart';

@GenerateMocks([JsonDecoder, AssetBundle, File])
void main() {
  late MockJsonDecoder mockJsonDecoder;
  late MockAssetBundle mockAssetBundle;
  late MockFile mockFile;
  late GroceryListLocalDataSourceImpl dataSourceImpl;

  setUp((() {
    mockJsonDecoder = MockJsonDecoder();
    mockAssetBundle = MockAssetBundle();
    mockFile = MockFile();
    dataSourceImpl = GroceryListLocalDataSourceImpl(
        mockJsonDecoder, mockAssetBundle, mockFile);
  }));

  // Define the expected results and the behavior of the mock asset bundle
  const groceryList =
      GroceryListModel(groceryListId: 1, groceryListName: 'List 1');
  final expected = [
    const GroceryListModel(groceryListId: 1, groceryListName: 'List 1'),
    const GroceryListModel(groceryListId: 2, groceryListName: 'List 2'),
    const GroceryListModel(groceryListId: 3, groceryListName: 'List 3'),
  ];
  const jsonStr =
      '[{"id": "1","name":"List 1"},{"id":"2","name":"List 2"},{"id":"3","name":"List 3"}]';
  const jsonStrWithIntIDs =
      '[{"id": 1,"name":"List 1"},{id:"2","name":"List 2"},{id:"3","name":"List 3"}]';

  group("GroceryList success when", () {
    test('getGroceryLists returns a list of GroceryListModels', () async {
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));
      when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));

      // Call the method under test and verify the result
      final result = await dataSourceImpl.getGroceryLists();
      expect(result, expected);
    });

    group('getGroceryList returns the GroceryListModel with the specified id',
        () {
      test('when id is a String', () async {
        // Define the expected results and the behavior of the mock asset bundle
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));

        // Call the method under test and verify the result
        final result = await dataSourceImpl.getGroceryList(groceryList.id);
        expect(result, groceryList);
      });
      test('when id is an integer', () async {
        // Define the expected results and the behavior of the mock asset bundle
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStrWithIntIDs));
        when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));

        // Call the method under test and verify the result
        final result = await dataSourceImpl.getGroceryList(groceryList.id);
        expect(result, groceryList);
      });
    });

    test('should add a new grocery list to the existing list', () async {
      // Arrange
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStrWithIntIDs));
      when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));
      when(mockFile.writeAsString(any))
          .thenAnswer((_) => Future<File>.value(MockFile()));

      // Act
      await dataSourceImpl.addGroceryList(groceryList);

      // Assert
      verify(mockAssetBundle.loadString(any)).called(1);
      verify(mockJsonDecoder.convert(any)).called(1);
      verify(mockFile.writeAsString(any)).called(1);
    });
    test('should updateGroceryList a  grocery list to the existing list',
        () async {
      // Arrange
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));
      when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));
      when(mockFile.writeAsString(any))
          .thenAnswer((_) => Future<File>.value(MockFile()));

      // Act
      await dataSourceImpl.updateGroceryList(groceryList.id, groceryList);

      // Assert
      verify(mockAssetBundle.loadString(any)).called(1);
      verify(mockJsonDecoder.convert(any)).called(1);
      verify(mockFile.writeAsString(any)).called(1);
    });
    test('should deleteGroceryList a  grocery list to the existing list',
        () async {
      // Arrange
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));
      when(mockJsonDecoder.convert(any)).thenReturn((json.decode(jsonStr)));
      when(mockFile.writeAsString(any))
          .thenAnswer((_) => Future<File>.value(MockFile()));

      // Act
      await dataSourceImpl.deleteGroceryList(groceryList.id);

      // Assert
      verify(mockAssetBundle.loadString(any)).called(1);
      verify(mockJsonDecoder.convert(any)).called(1);
      verify(mockFile.writeAsString(any)).called(1);
    });
  });

  group("GroceryList failure when", () {
    group("file system execption or format exception", () {
      // GetGroceryLists
      test(
          'getGroceryLists throws FileSystemException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any)).thenThrow(FileSystemException);

        // Call the method under test and verify the result
        expect(
            dataSourceImpl.getGroceryLists(), throwsA(isInstanceOf<Failure>()));
      });
      test('getGroceryLists throws FormatException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenThrow(FormatException);

        // Call the method under test and verify the result
        expect(
            dataSourceImpl.getGroceryLists(), throwsA(isInstanceOf<Failure>()));
      });

      //? GetGroceryList
      test(
          'getGroceryList throws FileSystemException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any)).thenThrow(FileSystemException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.getGroceryList(groceryList.id),
            throwsA(isInstanceOf<Failure>()));
      });
      test('getGroceryList throws FormatException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenThrow(FormatException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.getGroceryList(groceryList.id),
            throwsA(isInstanceOf<Failure>()));
      });

      //? AddGroceryList
      test(
          'addGroceryList throws FileSystemException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any)).thenThrow(FileSystemException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.addGroceryList(groceryList),
            throwsA(isInstanceOf<Failure>()));
      });
      test('addGroceryList throws FormatException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenThrow(FormatException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.addGroceryList(groceryList),
            throwsA(isInstanceOf<Failure>()));
      });

      //? UpdateGroceryList
      test(
          'updateGroceryList throws FileSystemException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any)).thenThrow(FileSystemException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.updateGroceryList(groceryList.id, groceryList),
            throwsA(isInstanceOf<Failure>()));
      });
      test(
          'updateGroceryList throws FormatException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenThrow(FormatException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.updateGroceryList(groceryList.id, groceryList),
            throwsA(isInstanceOf<Failure>()));
      });
      //? DeleteGroceryList
      test(
          'deleteGroceryList throws FileSystemException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any)).thenThrow(FileSystemException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.deleteGroceryList(groceryList.id),
            throwsA(isInstanceOf<Failure>()));
      });
      test(
          'deleteGroceryList throws FormatException a list of GroceryListModels',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => Future.value(jsonStr));
        when(mockJsonDecoder.convert(any)).thenThrow(FormatException);

        // Call the method under test and verify the result
        expect(dataSourceImpl.deleteGroceryList(groceryList.id),
            throwsA(isInstanceOf<Failure>()));
      });
    });
    test(
        'getGroceryList throws an exception when the GroceryListModel is not found',
        () async {
      // Define the behavior of the mock asset bundle
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));

      // Call the method under test and verify that an exception is thrown
      expect(
          dataSourceImpl.getGroceryList(4), throwsA(isInstanceOf<Failure>()));
    });
    test(
        'updateGroceryList throws an exception when the GroceryListModel is not found',
        () async {
      // Define the behavior of the mock asset bundle
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));

      // Call the method under test and verify that an exception is thrown
      expect(dataSourceImpl.updateGroceryList(groceryList.id, groceryList),
          throwsA(isInstanceOf<Failure>()));
    });
    test(
        'deleteGroceryList throws an exception when the GroceryListModel is not found',
        () async {
      // Define the behavior of the mock asset bundle
      when(mockAssetBundle.loadString(any))
          .thenAnswer((_) => Future.value(jsonStr));

      // Call the method under test and verify that an exception is thrown
      expect(dataSourceImpl.deleteGroceryList(groceryList.id),
          throwsA(isInstanceOf<Failure>()));
    });
  });
}
