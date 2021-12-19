import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, User>> getUsers();
}
