import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_item_repository.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_repository.dart';
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

import 'reusable_mocks.mocks.dart';

@GenerateMocks([
  // Repositories
  GroceryListRepository,
  GroceryListItemRepository,
  // UseCases
  GetGroceryListsUseCase,
  AddGroceryListUseCase,
  UpdateGroceryListUseCase,
  DeleteGroceryListUseCase,
  AddGroceryListItemUseCase,
  UpdateGroceryListItemUseCase,
  DeleteGroceryListItemUseCase,

  // Network
  NetworkInfo,
  InternetConnectionChecker,

  // DataSource Mock
  DioClient,
  GrcoeryListItemRemoteDataSource,
  GroceryListRemoteDataSource
])
class ReusableMocks {
  /*
  --------------------------------------
    Grocery Usecases & Grocery Manager
  --------------------------------------
  */
  late final MockGetGroceryListsUseCase mockGetGroceryListsUseCase;
  late final MockAddGroceryListUseCase mockAddGroceryListUseCase;
  late final MockUpdateGroceryListUseCase mockUpdateGroceryListUseCase;
  late final MockDeleteGroceryListUseCase mockDeleteGroceryListUseCase;
  late final MockUpdateGroceryListItemUseCase mockUpdateGroceryListItemUseCase;
  late final MockAddGroceryListItemUseCase mockAddGroceryListItemUseCase;
  late final MockDeleteGroceryListItemUseCase mockDeleteGroceryListItemUseCase;
  late GroceryManager groceryManager;

  void initGroceryManager() {
    mockGetGroceryListsUseCase = MockGetGroceryListsUseCase();
    mockAddGroceryListUseCase = MockAddGroceryListUseCase();
    mockUpdateGroceryListUseCase = MockUpdateGroceryListUseCase();
    mockDeleteGroceryListUseCase = MockDeleteGroceryListUseCase();
    mockUpdateGroceryListItemUseCase = MockUpdateGroceryListItemUseCase();
    mockAddGroceryListItemUseCase = MockAddGroceryListItemUseCase();
    mockDeleteGroceryListItemUseCase = MockDeleteGroceryListItemUseCase();
    groceryManager = GroceryManager(
        mockGetGroceryListsUseCase,
        mockAddGroceryListUseCase,
        mockUpdateGroceryListUseCase,
        mockDeleteGroceryListUseCase,
        mockUpdateGroceryListItemUseCase,
        mockAddGroceryListItemUseCase,
        mockDeleteGroceryListItemUseCase);
  }

  static final groceryManagerInit = GroceryManager(
      MockGetGroceryListsUseCase(),
      MockAddGroceryListUseCase(),
      MockUpdateGroceryListUseCase(),
      MockDeleteGroceryListUseCase(),
      MockUpdateGroceryListItemUseCase(),
      MockAddGroceryListItemUseCase(),
      MockDeleteGroceryListItemUseCase());

  /*
  -----------------------------
      Internet Connection
  -----------------------------
  */
  static void arrangeInternetConnectionHasConnection(
      mockInternetConnectionChecker) {
    final hasConnection = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnection);
  }

  static void arrangeInternetConnectionHasNoConnection(
      mockInternetConnectionChecker) {
    final hasConnection = Future.value(false);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnection);
  }
}
