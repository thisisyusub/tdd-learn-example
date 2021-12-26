import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/no_params.dart';
import '../../../../core/states/data_state.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_cases/get_users.dart';

export '../../../../core/states/data_state.dart';

class UsersCubit extends Cubit<DataState<List<User>>> {
  final GetUsers getUsers;

  UsersCubit(this.getUsers) : super(DataState.initial());

  void fetchUsers() async {
    emit(DataState.inProgress());

    final result = await getUsers(const NoParams());

    result.fold(
      (failure) => emit(DataState.failure()),
      (success) => emit(
        success.isEmpty ? DataState.empty() : DataState.success(success),
      ),
    );
  }
}
