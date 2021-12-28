import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_model.dart';

part 'post_remote_data_source.g.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getUserPosts(int userId);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  factory PostRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _PostRemoteDataSourceImpl;

  @GET('/posts')
  @override
  Future<List<PostModel>> getUserPosts(@Query('userId') int userId);
}
