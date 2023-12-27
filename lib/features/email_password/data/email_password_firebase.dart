import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordFirebase {
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('No Internet connection');
      } else if (e.code == 'wrong-password') {
        throw Exception('Given password is incorrect');
      } else if (e.code == 'user-not-found') {
        throw Exception('No user found for given email');
      } else if (e.code == 'too-many-requests') {
        throw Exception('Too many attempts, please try again later');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else {
        throw Exception('Unknown error');
      }
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmedPassword,
  }) async {
    if (email.isEmpty || password.isEmpty || confirmedPassword.isEmpty) {
      throw Exception('Please fill in all fields');
    }

    if (password != confirmedPassword) {
      throw Exception("Given passwords don't match");
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('No Internet connection');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else if (e.code == 'weak-password') {
        throw Exception('Given password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Account with given email already exist');
      } else {
        throw Exception('Unknown error');
      }
    }
  }

  Future<bool> resetPassword({
    required String passwordResetText,
  }) async {
    bool isReset = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: passwordResetText.trim(),
      );
    } on FirebaseAuthException catch (e) {
      isReset = false;
      if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else if (e.code == 'user-not-found') {
        throw Exception('User not found');
      } else {
        throw Exception('Unknown error');
      }
    }
    return isReset;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
