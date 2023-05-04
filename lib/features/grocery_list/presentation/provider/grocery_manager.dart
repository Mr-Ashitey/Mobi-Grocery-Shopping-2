import 'package:flutter/foundation.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/model/grocery_list_model.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/delete_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/update_grocery_list_usecase.dart';

import '../../data/model/grocery_list_item_model.dart';
import '../../domain/usecases/grocery_list_item_usecases/add_grocery_list_item_usecase.dart';
import '../../domain/usecases/grocery_list_item_usecases/update_grocery_list_item_usecase.dart';
import '../../domain/usecases/grocery_list_usecases/add_grocery_list_usecase.dart';
import '../../domain/usecases/grocery_list_usecases/delete_grocery_list_usecase.dart';
import '../../domain/usecases/grocery_list_usecases/get_grocery_lists_usecase.dart';

enum NotifierState { initial, loading, loaded }

class GroceryManager extends ChangeNotifier {
  // Grocery List Usecases
  final GetGroceryListsUseCase _getGroceryListsUseCase;
  final AddGroceryListUseCase _addGroceryListsUseCase;
  final UpdateGroceryListUseCase _updateGroceryListUseCase;
  final DeleteGroceryListUseCase _deleteGroceryListUseCase;

  // Grocery List Item Usecases
  final AddGroceryListItemUseCase _addGroceryListItemUseCase;
  final UpdateGroceryListItemUseCase _updateGroceryListItemUseCase;
  final DeleteGroceryListItemUseCase _deleteGroceryListItemUseCase;

  // Private variables to handle grocery lists and notifier state
  List<GroceryListModel> _groceryLists = [];
  GroceryListModel? _groceryList;
  NotifierState _notifierState = NotifierState.initial;

  // Getters to access variables
  List<GroceryListModel> get groceryLists => [..._groceryLists];
  GroceryListModel? get groceryList => _groceryList;
  NotifierState get notifierState => _notifierState;

  GroceryManager(
      this._getGroceryListsUseCase,
      this._addGroceryListsUseCase,
      this._updateGroceryListUseCase,
      this._deleteGroceryListUseCase,
      this._updateGroceryListItemUseCase,
      this._addGroceryListItemUseCase,
      this._deleteGroceryListItemUseCase);

  // Sets the loading state and notifies the listeners
  void _setLoading(NotifierState state) {
    _notifierState = state;
    notifyListeners();
  }

  // Retrieves all the grocery lists
  // and sets the internal grocery lists accordingly
  Future<void> getGroceryLists() async {
    final result = await _getGroceryListsUseCase.call();

    result.fold(
      (failure) => throw failure,
      (groceryLists) {
        _groceryLists = groceryLists as List<GroceryListModel>;
        notifyListeners();
      },
    );
  }

  // Get a specific grocery list by ID
  Future<void> getGroceryList(int id) async {
    try {
      _groceryList = null;
      _groceryList = _groceryLists.firstWhere((list) => list.id == id);
    } catch (error) {
      rethrow;
    }
  }

  // Add a new grocery list
  // and updates the internal grocery lists accordingly
  Future<void> addGroceryList(GroceryListModel groceryList) async {
    _setLoading(NotifierState.loading);
    final result = await _addGroceryListsUseCase.call(groceryList);

    result.fold(
      (failure) {
        _setLoading(NotifierState.initial);
        throw failure;
      },
      (_) {
        _groceryLists.add(groceryList);
        _setLoading(NotifierState.loaded);
      },
    );
  }

  // Updates an existing grocery list by ID
  // and updates the internal grocery lists accordingly
  Future<void> updateGroceryList(int id, GroceryListModel groceryList) async {
    _setLoading(NotifierState.loading);
    final result = await _updateGroceryListUseCase.call(id, groceryList);

    result.fold(
      (failure) {
        _setLoading(NotifierState.initial);
        throw failure;
      },
      (_) {
        final index = _groceryLists.indexWhere((list) => list.id == id);
        if (index != -1) {
          _groceryLists[index] = groceryList;
        }
        _setLoading(NotifierState.loaded);
      },
    );
  }

  // Deletes an existing grocery list by ID
  // and updates the internal grocery lists accordingly
  Future<void> deleteGroceryList(int id) async {
    _setLoading(NotifierState.loading);
    final result = await _deleteGroceryListUseCase.call(id);

    result.fold(
      (failure) {
        _setLoading(NotifierState.initial);
        throw failure;
      },
      (_) {
        _groceryLists.removeWhere((list) => list.id == id);
        _setLoading(NotifierState.loaded);
      },
    );
  }

  // Adds a new grocery list item to a grocery list
  // and updates the internal grocery lists accordingly
  Future<void> addGroceryListItem(
      int groceryListId, GroceryListItemModel groceryListItem) async {
    _setLoading(NotifierState.loading);
    final result = await _addGroceryListItemUseCase.call(groceryListItem);

    result.fold(
      (failure) {
        _setLoading(NotifierState.initial);
        throw failure;
      },
      (_) {
        final index =
            _groceryLists.indexWhere((list) => list.id == groceryListId);
        if (index != -1) {
          _groceryLists[index].groceryListItems.add(groceryListItem);
        }
        _setLoading(NotifierState.loaded);
      },
    );
  }

  // Updates an existing grocery list item
  // and updates the internal grocery lists accordingly
  Future<void> updateGroceryListItem(
      GroceryListItemModel groceryListItem) async {
    _setLoading(NotifierState.loading);
    final result = await _updateGroceryListItemUseCase.call(groceryListItem);

    result.fold(
      (failure) {
        _setLoading(NotifierState.initial);
        throw failure;
      },
      (_) {
        final index = _groceryLists
            .indexWhere((list) => list.id == groceryListItem.groceryListId);
        if (index != -1) {
          final indexitemIndex = _groceryLists[index]
              .groceryListItems
              .indexWhere((item) => item.id == groceryListItem.id);

          if (indexitemIndex != -1) {
            _groceryLists[index].groceryListItems[indexitemIndex] =
                groceryListItem;
          }
        }
        _setLoading(NotifierState.loaded);
      },
    );
  }

  // Deletes an existing grocery list item by ID
  // and updates the internal grocery lists accordingly
  Future<void> deleteGroceryListItem(int listId, int itemId) async {
    final result = await _deleteGroceryListItemUseCase.call(itemId);

    result.fold(
      (failure) => throw failure,
      (_) {
        _groceryLists
            .firstWhere((groceryList) => groceryList.id == listId)
            .groceryListItems
            .removeWhere((item) => item.id == itemId);
        notifyListeners();
      },
    );
  }

  // returns all grocery list items from all existing grocery lists.
  List<GroceryListItemModel> getAllGroceryItems() {
    return _groceryLists
        .expand((list) => list.groceryListItems)
        .cast<GroceryListItemModel>()
        .toList();
  }
}
