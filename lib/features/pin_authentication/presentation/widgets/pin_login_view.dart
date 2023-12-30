import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/widgets/pin_buttons_grid.dart';
import 'package:login_tester/features/pin_authentication/presentation/widgets/pin_length_indicator.dart';
import 'package:login_tester/success_screen.dart';

class PinLoginView extends StatefulWidget {
  const PinLoginView({super.key});

  @override
  State<PinLoginView> createState() => _PinLoginViewState();
}

class _PinLoginViewState extends State<PinLoginView> {
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
    return Column(
      children: [
        const SizedBox(height: 20),
        BlocListener<PinAuthenticationBloc, PinAuthenticationState>(
          listener: (context, state) {
            if (state is PinAuthenticationError) {
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
            } else if (state is PinAuthenticationSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SuccessScreen(
                    userType: 'PIN Authentication',
                    onLogOut: () async {
                      context.read<PinAuthenticationBloc>().add(
                            AuthViewChanged(
                              view: AuthView.login,
                            ),
                          );
                      context.read<PinAuthenticationBloc>().add(
                            PinCodeDeleting(operationType: 'clear'),
                          );
                      Navigator.of(context).pop();
                    },
                    onDeleteAccount: () async {
                      context.read<PinAuthenticationBloc>().add(
                            PinCodeDeleting(operationType: 'clear'),
                          );
                      context.read<PinAuthenticationBloc>().add(
                            AuthViewChanged(
                              view: AuthView.register,
                            ),
                          );
                      context
                          .read<PinAuthenticationBloc>()
                          .add(DeleteUserPressed());
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Hi, ${context.read<PinAuthenticationBloc>().getLocalUserEmail()} !',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Enter your PIN code',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const PinLengthIndicator(),
                    const PinButtonsGrid(),
                    BlocBuilder<PinAuthenticationBloc, PinAuthenticationState>(
                      builder: (context, state) {
                        if (state is PinAuthenticationLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              context.read<PinAuthenticationBloc>().add(
                                    LoginButtonPressed(),
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
                            _emailController.clear();
                            context.read<PinAuthenticationBloc>().add(
                                  PinCodeDeleting(operationType: 'clear'),
                                );
                            context.read<PinAuthenticationBloc>().add(
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
