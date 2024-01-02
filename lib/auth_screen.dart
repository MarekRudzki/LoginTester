// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:login_tester/features/anonymous/presentation/anonymous.dart';
import 'package:login_tester/features/email_password/presentation/email_password.dart';
import 'package:login_tester/features/fingerprint_recognition/fingerprint_recognition.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/login_selection/widgets/login_methods.dart';
import 'package:login_tester/features/pattern_unlock/presentation/pattern_unlock.dart';
import 'package:login_tester/features/phone_number/presentation/phone_number.dart';
import 'package:login_tester/features/pin_authentication/presentation/pin_authentication.dart';
import 'package:login_tester/features/social_media_accounts/social_media_accounts.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentLoginIndex =
        context.watch<LoginProvider>().selectedLoginValue;

    final List<Widget> availableLoginMethods = [
      const Anonymous(),
      const EmailPassword(),
      const PhoneNumber(),
      const SocialMediaAccounts(),
      const PinAuthentication(),
      const PatternUnlock(),
      const FingerprintRecognition(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  if (currentLoginIndex == 0)
                    const Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Welcome to Login Tester App!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Here you can check out the different ways to log in to the application.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    )
                  else
                    const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            insetPadding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              child: const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      'Login Method:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    LoginMethods(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Select method',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (currentLoginIndex == 0)
                    const SizedBox.shrink()
                  else
                    availableLoginMethods[currentLoginIndex - 1],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
