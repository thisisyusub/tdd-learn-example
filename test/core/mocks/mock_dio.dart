import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

@GenerateMocks([Dio, HttpClientAdapter])
void generateMockDio() {}
