import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class GetUsers {
  final IUserRepository userRepository;

  GetUsers(this.userRepository);

  Future<Either<Failure, List<User>>> execute() async {
    return await userRepository.getUsers();
  }
}
