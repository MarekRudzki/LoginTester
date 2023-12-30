import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/email_password/presentation/widgets/custom_text_field.dart';
import 'package:login_tester/features/email_password/presentation/widgets/reset_password.dart';
import 'package:login_tester/success_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordResetController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordResetController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordResetController.dispose();
  }

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _passwordResetController.clear();
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
                                    LoginButtonPressed(
                                      email: _emailController.text,
                                      password: _passwordController.text,
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
                                  'Log In',
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
                          'Don\'t have an account?',
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
                                    view: AuthView.register,
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
                              'Register now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ResetPassword(
                                  controller: _passwordResetController,
                                );
                              },
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
                              'Click here to reset',
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
