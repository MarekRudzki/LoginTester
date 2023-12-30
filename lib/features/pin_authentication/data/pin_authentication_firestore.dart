import 'package:cloud_firestore/cloud_firestore.dart';

class PinAuthenticationFirestore {
  Future<void> addUser({
    required String email,
    required String pinCode,
  }) async {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': email,
        'pin_code': pinCode,
      },
    );
  }

  Future<String> getUserPinCode({
    required String email,
  }) async {
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('users');

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();

    return querySnapshot.docs.first['pin_code'] as String;
  }
}
