import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/states/data_state.dart';
import '../../domain/entities/post.dart';
import '../bloc/user_posts_cubit.dart';
import '../widgets/failure_widget.dart';
import '../widgets/list_item.dart';
import '../widgets/loading_widget.dart';

class UserPostsPage extends StatelessWidget {
  const UserPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostsCubit, DataState<List<Post>>>(
      builder: (context, state) {
        late final Widget body;

        if (state.isInProgress) {
          body = const LoadingWidget();
        } else if (state.isFailure) {
          body = const FailureWidget();
        } else if (state.isEmpty) {
          body = const Text('No Post!');
        } else if (state.isSuccess) {
          body = ListView.builder(
            itemBuilder: (_, index) {
              final userPost = state.data![index];

              return ListItem(
                leading: '${userPost.id}',
                title: userPost.title,
                body: userPost.body,
              );
            },
            itemCount: state.data!.length,
          );
        } else {
          body = const SizedBox.shrink();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Posts'),
          ),
          body: body,
        );
      },
    );
  }
}
