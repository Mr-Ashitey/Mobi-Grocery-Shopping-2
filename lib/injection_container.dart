import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobi_grocery_shopping_2/core/api/dio_client.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/datasources/grocery_list_item_remote_datasource.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/data/repositories_impl/grocery_list_repository_impl.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_repository.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/add_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/delete_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';

import 'features/grocery_list/data/datasources/grocery_list_remote_datasource.dart';
import 'features/grocery_list/data/repositories_impl/grocery_list_item_repository_impl.dart';
import 'features/grocery_list/domain/repositories/grocery_list_item_repository.dart';
import 'features/grocery_list/domain/usecases/grocery_list_item_usecases/add_grocery_list_item_usecase.dart';
import 'features/grocery_list/domain/usecases/grocery_list_item_usecases/delete_grocery_list_item_usecase.dart';
import 'features/grocery_list/domain/usecases/grocery_list_item_usecases/update_grocery_list_item_usecase.dart';
import 'features/grocery_list/domain/usecases/grocery_list_usecases/get_grocery_lists_usecase.dart';
import 'features/grocery_list/domain/usecases/grocery_list_usecases/update_grocery_list_usecase.dart';

final GetIt locator = GetIt.instance;

Future<void> initGetIt() async {
  // Provider
  locator.registerFactory(() => GroceryManager(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // Use cases
  //? -- Grocery List Usecase
  locator.registerLazySingleton(() => AddGroceryListUseCase(locator()));
  locator.registerLazySingleton(() => DeleteGroceryListUseCase(locator()));
  locator.registerLazySingleton(() => GetGroceryListsUseCase(locator()));
  locator.registerLazySingleton(() => UpdateGroceryListUseCase(locator()));
  //? -- Grocery List Item Usecase
  locator.registerLazySingleton(() => AddGroceryListItemUseCase(locator()));
  locator.registerLazySingleton(() => DeleteGroceryListItemUseCase(locator()));
  locator.registerLazySingleton(() => UpdateGroceryListItemUseCase(locator()));

  // Repository
  //? -- Grocery List Usecase
  locator.registerLazySingleton<GroceryListRepository>(
    () => GroceryListRepositoryImpl(
        groceryListRemoteDataSource: locator(), networkInfo: locator()),
  );
  //? -- Grocery List Item Usecase
  locator.registerLazySingleton<GroceryListItemRepository>(
    () => GroceryListItemRepositoryImpl(
        groceryListItemRemoteDataSource: locator(), networkInfo: locator()),
  );

  // Data sources
  //? -- Grocery List Usecase
  locator.registerLazySingleton<GroceryListRemoteDataSource>(
    () => GrcoeryListRemoteDataSourceImpl(locator()),
  );

  //? -- Grocery List Item Usecase
  locator.registerLazySingleton<GrcoeryListItemRemoteDataSource>(
    () => GrcoeryListItemRemoteDataSourceImpl(locator()),
  );

  // Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // External
  locator.registerLazySingleton(() => DioClient());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
