import 'package:flutter/material.dart';
import 'package:login_tester/features/anonymous/anonymous.dart';
import 'package:login_tester/features/email_password/presentation/email_password.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/login_selection/widgets/login_methods.dart';
import 'package:login_tester/features/phone_number/presentation/phone_number.dart';
import 'package:login_tester/features/social_media_accounts/social_media_accounts.dart';
import 'package:provider/provider.dart';

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
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome to Login Tester App!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Here you can check out the different ways to log in to the application.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
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
                            height: MediaQuery.sizeOf(context).height * 0.6,
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
    );
  }
}
