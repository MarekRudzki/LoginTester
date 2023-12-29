import 'package:hive_flutter/hive_flutter.dart';

class PinAuthenticationHive {
  final _pinBox = Hive.box('pin_auth');

  Future<void> addUser({
    required String email,
  }) async {
    await _pinBox.put('user_email', email);
  }

  String getUserEmail() {
    final String email = _pinBox.get('user_email') as String;
    return email;
  }

  bool isUserSaved() {
    return _pinBox.containsKey('user_email');
  }
}
