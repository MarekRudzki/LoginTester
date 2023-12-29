import 'package:firebase_auth/firebase_auth.dart';

class AnonymousFirebase {
  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
