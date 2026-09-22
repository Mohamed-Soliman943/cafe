import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;


  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    final credential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.sendEmailVerification();

    return credential;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // Stream<User?> get authStateChanges => _auth.authStateChanges();
}