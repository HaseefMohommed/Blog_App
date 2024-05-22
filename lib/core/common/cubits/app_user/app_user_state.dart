part of 'app_user_cubit.dart';

abstract class AppUserState {}

class AppUserInitial extends AppUserState {}

class AppUserSignedIn extends AppUserState {
  final User user;

  AppUserSignedIn({
    required this.user,
  });
}
