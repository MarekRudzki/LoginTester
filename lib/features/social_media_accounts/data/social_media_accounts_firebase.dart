import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaAccountsFirebase {
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle({
    required AuthCredential credential,
  }) async {
    await _auth.signInWithCredential(credential);
  }

  Future<void> signInWithCredential({
    required OAuthCredential credential,
  }) async {
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteGoogleAccount() async {
    await GoogleSignIn().signOut();
    await _auth.currentUser?.delete();
  }

  Future<void> deleteTwitterAccount() async {
    await _auth.currentUser?.delete();
  }

  Future<void> deleteFacebookAccount() async {
    await FacebookAuth.instance.logOut();
    await _auth.currentUser?.delete();
  }
}
