import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getUserPosts(int userId);
}
