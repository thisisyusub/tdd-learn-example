import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers implements Usecase<List<User>, NoParams> {
  final UserRepository userRepository;

  GetUsers(this.userRepository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) =>
      userRepository.getUsers();
}
