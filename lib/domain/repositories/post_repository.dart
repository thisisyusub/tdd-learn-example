import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getUserPosts(int userId);
}
