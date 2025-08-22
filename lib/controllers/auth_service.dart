import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Account has been successfully created.";
    } on FirebaseAuthException catch (error) {
      return error.message.toString();
    }
  }

  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "You successfully logged in";
    } on FirebaseAuthException catch (error) {
      print(error.message.toString());

      return error.message.toString();
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<bool> isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;

    return user != null;
  }
}
