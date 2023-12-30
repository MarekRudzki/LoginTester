import 'package:cloud_firestore/cloud_firestore.dart';

class PatternFirestore {
  Future<void> addUser({
    required String email,
    required List<int> pattern,
  }) async {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': email,
        'pattern': pattern,
      },
    );
  }

  Future<List<dynamic>> getUserPattern({
    required String email,
  }) async {
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('users');

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();

    return querySnapshot.docs.first['pattern'] as List<dynamic>;
  }
}
