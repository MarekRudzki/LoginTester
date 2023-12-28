import 'package:firebase_auth/firebase_auth.dart';

class SocialMediaAccountsFirebase {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle({
    required AuthCredential credential,
  }) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInWithCredential({
    required OAuthCredential credential,
  }) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
