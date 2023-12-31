// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        'Reset your password?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: const Text(
        textAlign: TextAlign.center,
        softWrap: true,
        'Enter the email adress associated with your account',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.teal,
      actions: [
        Column(
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                label: const Center(
                  child: Text('Input your email'),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            BlocBuilder<EmailPasswordBloc, EmailPasswordState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state is EmailPasswordError
                      ? Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            BlocConsumer<EmailPasswordBloc, EmailPasswordState>(
              listener: (context, state) {
                if (state is EmailPasswordSuccess) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Check your mailbox',
                          style: TextStyle(color: Colors.white70),
                        ),
                        content: const Text(
                          'You should find link to reset your password in your mailbox.',
                          style: TextStyle(color: Colors.white70),
                        ),
                        backgroundColor: Colors.teal,
                        actions: [
                          Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is EmailPasswordLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<EmailPasswordBloc>().add(
                              PasswordResetPressed(
                                  passwordResetEmail: controller.text.trim()));
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.clear();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
