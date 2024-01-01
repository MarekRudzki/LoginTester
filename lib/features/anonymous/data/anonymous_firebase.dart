// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnonymousFirebase {
  final _auth = FirebaseAuth.instance;

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }
}
