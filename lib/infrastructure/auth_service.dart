import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Error in signIn: $e");
      return null;
    }
  }

  // Register with email and password
  Future<User?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Error in register: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if user is authenticated
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}