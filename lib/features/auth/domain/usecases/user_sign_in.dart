import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UsersignIn extends UseCase<User, UserSignParams> {
  final AuthRepository authRepository;

  UsersignIn({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignParams {
  final String email;
  final String password;

  UserSignParams({
    required this.email,
    required this.password,
  });
}
