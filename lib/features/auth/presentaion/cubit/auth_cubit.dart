import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../services/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await authService.login(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await authService.register(
        email: email,
        password: password,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Registration failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authService.logout();

      emit(LogoutSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Logout failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    try {
      final user = authService.currentUser;

      print('CURRENT USER: $user');
      print('USER EMAIL: ${user?.email}');
      print('VERIFIED: ${user?.emailVerified}');

      if (user == null) {
        emit(Unauthenticated());
        return;
      }

      if (user.emailVerified) {
        emit(Authenticated());
      } else {
        emit(EmailNotVerified());
      }
    } catch (e) {
      print('AUTH CHECK ERROR: $e');
      emit(AuthError(e.toString()));
    }
  }
}
