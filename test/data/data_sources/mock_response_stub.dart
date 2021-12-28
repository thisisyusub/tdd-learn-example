import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';

extension MockStub on MockHttpClientAdapter {
  void createMockResponseStub(String body, int statusCode) {
    final response = ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(fetch(any, any, any)).thenAnswer(
      (_) async {
        return response;
      },
    );
  }
}
