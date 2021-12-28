import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.postRemoteDataSource);

  final PostRemoteDataSource postRemoteDataSource;

  @override
  Future<Either<Failure, List<Post>>> getUserPosts(int userId) async {
    try {
      return Right(await postRemoteDataSource.getUserPosts(userId));
    } on DioError {
      return Left(ServerFailure());
    }
  }
}
