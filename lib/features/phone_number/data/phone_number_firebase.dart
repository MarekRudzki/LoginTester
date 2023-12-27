import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

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
  Future<VerificationResult> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    final Completer<VerificationResult> completer =
        Completer<VerificationResult>();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
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
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
