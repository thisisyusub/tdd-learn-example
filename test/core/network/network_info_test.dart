import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/network/network_info.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('should call Connectivity.checkConnectivity() to check network state',
        () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => ConnectivityResult.wifi,
      );

      final result = await networkInfoImpl.isConnected;

      verify(mockConnectivity.checkConnectivity());
      verifyNoMoreInteractions(mockConnectivity);
      expect(result, true);
    });
  });
}
