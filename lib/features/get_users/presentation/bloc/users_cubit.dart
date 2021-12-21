import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/no_params.dart';
import '../../../../core/states/data_state.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

class UserCubit extends Cubit<DataState<List<User>>> {
  final GetUsers getUsers;

  UserCubit(this.getUsers) : super(const DataState.initial());

  void fetchUsers() async {
    emit(const DataState.inProgress());

    final result = await getUsers(const NoParams());

    result.fold(
      (failure) => emit(const DataState.failure()),
      (success) => emit(DataState.success(success)),
    );
  }
}
