import 'package:dartz/dartz.dart';
import 'package:tdd_example/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserById implements Usecase<User, int> {
  final UserRepository userRepository;

  GetUserById(this.userRepository);

  @override
  Future<Either<Failure, User>> call(int id) => userRepository.getUser(id);
}
