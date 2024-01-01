// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
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

  Future<void> deteleFirestoreAccount({
    required String email,
  }) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    final DocumentReference userRef = querySnapshot.docs.first.reference;

    await userRef.delete();
  }
}
