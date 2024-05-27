import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UsersignIn _usersignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UsersignIn usersignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _usersignIn = usersignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(
      UserSignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    response.fold((failure) => emit(AuthFaliure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _usersignIn(
      UserSignParams(email: event.email, password: event.password),
    );
    response.fold((failure) => emit(AuthFaliure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());

    response.fold((failure) => emit(AuthFaliure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user),
    );
  }

  void _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    _appUserCubit.clearUser();
    emit(AuthInitial());
  }
}
