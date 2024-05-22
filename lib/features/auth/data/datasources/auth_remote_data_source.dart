import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUsersession;
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImp({required this.supabaseClient});

  @override
  Session? get currentUsersession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUsersession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUsersession!.user.id,
            );
        return UserModel.fromJson(Map<String, dynamic>.from(userData.first)).copyWith(
          email: currentUsersession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
