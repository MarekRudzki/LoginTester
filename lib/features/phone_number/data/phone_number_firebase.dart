// Dart imports:
import 'dart:async';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

enum VerificationStatus { completed, failed, codeSent, timeout }

class VerificationResult {
  final VerificationStatus status;
  final String? errorMessage;
  final String? verificationId;

  VerificationResult(
    this.status, {
    this.errorMessage,
    this.verificationId,
  });
}

class PhoneNumberFirebase {
  final _auth = FirebaseAuth.instance;

  Future<VerificationResult> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    final Completer<VerificationResult> completer =
        Completer<VerificationResult>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        completer.complete(VerificationResult(VerificationStatus.completed));
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.complete(VerificationResult(VerificationStatus.failed,
            errorMessage: e.message));
      },
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(VerificationResult(VerificationStatus.codeSent,
            verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.complete(VerificationResult(VerificationStatus.timeout));
      },
    );
    return completer.future;
  }

  Future<void> signInWithCredential(
      {required AuthCredential credential}) async {
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }
}
