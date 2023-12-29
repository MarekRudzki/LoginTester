import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_tester/features/pin_authentication/data/user_model.dart';

class PinAuthenticationFirestore {
  Future<void> addUser({
    required UserModel userModel,
  }) async {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': userModel.email,
        'pin_code': userModel.pinCode,
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
