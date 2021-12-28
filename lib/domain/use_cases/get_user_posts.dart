import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetUserPosts implements Usecase<List<Post>, int> {
  final PostRepository postRepository;

  GetUserPosts(this.postRepository);

  @override
  Future<Either<Failure, List<Post>>> call(int userId) =>
      postRepository.getUserPosts(userId);
}
