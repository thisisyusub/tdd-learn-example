import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/user.dart';
import '../app_router.dart';
import '../bloc/users_cubit.dart';
import '../widgets/failure_widget.dart';
import '../widgets/list_item.dart';
import '../widgets/loading_widget.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => getIt<UsersCubit>()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: BlocBuilder<UsersCubit, DataState<List<User>>>(
          builder: (context, state) {
            if (state.isInProgress) {
              return const LoadingWidget();
            } else if (state.isFailure) {
              return const FailureWidget();
            } else if (state.isEmpty) {
              return const Text('No User!');
            } else if (state.isSuccess) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final user = state.data![index];

                  return ListItem(
                    leading: '${user.id}',
                    title: user.name,
                    body: user.email,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.userPosts,
                        arguments: user.id,
                      );
                    },
                  );
                },
                itemCount: state.data!.length,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
