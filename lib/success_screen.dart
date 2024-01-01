// Flutter imports:
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String userType;
  final VoidCallback onLogOut;
  final VoidCallback onDeleteAccount;

  const SuccessScreen({
    super.key,
    required this.userType,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                const Text(
                  'You have successfully connected with:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  userType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onLogOut,
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    if (userType != 'Fingerprint recognition')
                      ElevatedButton(
                        onPressed: onDeleteAccount,
                        child: const Text(
                          'Delete account',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
