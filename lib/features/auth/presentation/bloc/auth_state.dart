part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);

}

class AuthFaliure extends AuthState {
  final Failure failure;

  AuthFaliure(this.failure);
}
