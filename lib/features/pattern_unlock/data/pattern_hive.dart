// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PatternHive {
  final _patternHive = Hive.box('pattern_auth');

  Future<void> addUser({
    required String email,
  }) async {
    await _patternHive.put('user_email', email);
  }

  String getUserEmail() {
    final String email = _patternHive.get('user_email') as String;
    return email;
  }

  bool isUserSaved() {
    return _patternHive.containsKey('user_email');
  }

  Future<void> deleteUser() async {
    await _patternHive.delete('user_email');
  }
}
