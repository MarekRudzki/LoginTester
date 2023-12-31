// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:login_tester/features/email_password/presentation/widgets/custom_text_field.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/widgets/pattern_drawer.dart';
import 'package:login_tester/success_screen.dart';

class PatternRegisterView extends StatefulWidget {
  const PatternRegisterView({super.key});

  @override
  State<PatternRegisterView> createState() => _PatternRegisterViewState();
}

class _PatternRegisterViewState extends State<PatternRegisterView> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPatternDrawed = context.watch<PatternBloc>().userPattern.isNotEmpty;
    final userExists = context.read<PatternBloc>().userExistsLocal();

    return BlocListener<PatternBloc, PatternState>(
      listener: (context, state) {
        if (state is PatternError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
              duration: const Duration(
                seconds: 3,
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is PatternSuccess) {
          _emailController.clear();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                userType: 'Pattern Unlock',
                onLogOut: () async {
                  context.read<PatternBloc>().add(
                        AuthViewChanged(
                          view: AuthView.login,
                        ),
                      );
                  Navigator.of(context).pop();
                },
                onDeleteAccount: () async {
                  context.read<PatternBloc>().add(DeleteUserPressed());
                  context.read<PatternBloc>().add(
                        AuthViewChanged(view: AuthView.register),
                      );
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 108, 178, 186),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Enter your email',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isPatternDrawed
                        ? 'Pattern captured!'
                        : 'Draw pattern (min. 4 dots)',
                    style: TextStyle(
                      color:
                          isPatternDrawed ? Colors.green : Colors.grey.shade300,
                      fontSize: 16,
                    ),
                  ),
                  const PatternDrawer(),
                  BlocBuilder<PatternBloc, PatternState>(
                    builder: (context, state) {
                      if (state is PatternLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            context.read<PatternBloc>().add(
                                  RegisterButtonPressed(
                                    email: _emailController.text,
                                  ),
                                );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.045,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal,
                            ),
                            child: const Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  if (userExists)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _emailController.clear();
                            context.read<PatternBloc>().add(
                                  AuthViewChanged(
                                    view: AuthView.login,
                                  ),
                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: const Text(
                              'Try login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
