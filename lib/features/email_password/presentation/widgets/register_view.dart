import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/email_password/presentation/widgets/custom_text_field.dart';
import 'package:login_tester/success_screen.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmedPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmedPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
  }

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _confirmedPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        BlocListener<EmailPasswordBloc, EmailPasswordState>(
          listener: (context, state) {
            if (state is EmailPasswordError) {
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
            } else if (state is EmailPasswordSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuccessScreen(
                    userType: 'Email & Password',
                    onLogOut: () async {
                      clearControllers();
                      context.read<EmailPasswordBloc>().add(LogoutPressed());
                      context.read<EmailPasswordBloc>().add(
                            AuthViewChanged(
                              view: AuthView.login,
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    onDeleteAccount: () async {
                      clearControllers();
                      context
                          .read<EmailPasswordBloc>()
                          .add(DeleteAccountPressed());
                      context.read<EmailPasswordBloc>().add(
                            AuthViewChanged(
                              view: AuthView.login,
                            ),
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
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Enter your password',
                      obscure: true,
                      inputAction: TextInputAction.done,
                      icon: Icons.key,
                    ),
                    CustomTextField(
                      controller: _confirmedPasswordController,
                      labelText: 'Confirm your password',
                      obscure: true,
                      inputAction: TextInputAction.done,
                      icon: Icons.key,
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<EmailPasswordBloc, EmailPasswordState>(
                      builder: (context, state) {
                        if (state is EmailPasswordLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<EmailPasswordBloc>().add(
                                    RegisterButtonPressed(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      confirmedPassword:
                                          _confirmedPasswordController.text,
                                    ),
                                  );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
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
                            clearControllers();
                            context.read<EmailPasswordBloc>().add(
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
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
