import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserById {
  final UserRepository userRepository;

  GetUserById(this.userRepository);

  Future<Either<Failure, User>> call(int id) => userRepository.getUser(id);
}
