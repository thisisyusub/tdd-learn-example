import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'bloc/user_posts_cubit.dart';
import 'pages/user_posts_page.dart';

abstract class Routes {
  static const userPosts = '/userPosts';
}

abstract class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.userPosts:
        assert(arguments != null);
        assert(arguments is int);

        return MaterialPageRoute(builder: (_) {
          return BlocProvider<UserPostsCubit>(
            create: (_) => getIt<UserPostsCubit>()
              ..fetchUserPosts(
                arguments! as int,
              ),
            child: const UserPostsPage(),
          );
        });

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('${settings.name} page is not found!'),
              ),
            );
          },
        );
    }
  }
}
