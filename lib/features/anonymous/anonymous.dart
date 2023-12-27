import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_tester/success_screen.dart';

class Anonymous extends StatelessWidget {
  const Anonymous({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.15,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signInAnonymously();

              if (!context.mounted) return;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuccessScreen(
                    userType: 'Anonymous Account',
                    onLogOut: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error occured: ${e.message}',
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(
                    seconds: 3,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Login anonymously'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
