import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  test(
      'should forward the call to InternetConnectionChecker.hasConection when is connected and indicate connection state',
      () async {
    // arrange
    final hasConnection = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnection);

    // act
    final result = networkInfoImpl.isConnected;

    // assert
    verify(mockInternetConnectionChecker.hasConnection).called(1);
    expect(result, hasConnection);
  });
  test(
      'should forward the call to InternetConnectionChecker.hasConection when is not connected and indicate connection state',
      () async {
    // arrange
    final hasConnection = Future.value(false);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => hasConnection);

    // act
    final result = networkInfoImpl.isConnected;

    // assert
    verify(mockInternetConnectionChecker.hasConnection).called(1);
    expect(result, hasConnection);
  });
}
