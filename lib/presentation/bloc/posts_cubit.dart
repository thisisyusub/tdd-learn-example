import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/states/data_state.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_user_posts.dart';

class PostsCubit extends Cubit<DataState<List<Post>>> {
  PostsCubit(this.getUserPosts) : super(DataState.initial());

  final GetUserPosts getUserPosts;

  void fetchUserPosts(int userId) async {
    emit(DataState.inProgress());

    final result = await getUserPosts(userId);

    result.fold(
      (failure) => emit(DataState.failure()),
      (success) {
        emit(success.isEmpty ? DataState.empty() : DataState.success(success));
      },
    );
  }
}
