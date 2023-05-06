import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_grocery_shopping_2/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

import '../../test_helpers/reusable_mocks.dart';
import '../../test_helpers/reusable_mocks.mocks.dart';

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
    ReusableMocks.arrangeInternetConnectionHasConnection(
        mockInternetConnectionChecker);

    // act
    final result = await networkInfoImpl.isConnected;

    // assert
    verify(mockInternetConnectionChecker.hasConnection).called(1);
    expectLater(result, equals(true));
  });
  test(
      'should forward the call to InternetConnectionChecker.hasConection when is not connected and indicate connection state',
      () async {
    // arrange
    ReusableMocks.arrangeInternetConnectionHasNoConnection(
        mockInternetConnectionChecker);
    // act
    final result = await networkInfoImpl.isConnected;

    // assert
    verify(mockInternetConnectionChecker.hasConnection).called(1);
    expect(result, equals(false));
  });
}
