import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/widgets/pattern_drawer.dart';
import 'package:login_tester/success_screen.dart';

class PatternLoginView extends StatefulWidget {
  const PatternLoginView({super.key});

  @override
  State<PatternLoginView> createState() => _PatternLoginViewState();
}

class _PatternLoginViewState extends State<PatternLoginView> {
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
        BlocListener<PatternBloc, PatternState>(
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
                        'Hi, ${context.read<PatternBloc>().getLocalUserEmail()} !',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Draw your pattern',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<PatternBloc, PatternState>(
                      builder: (context, state) {
                        if (state is PatternLoading) {
                          return Container(
                            height: 250,
                            width: double.infinity,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return const PatternDrawer();
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
                            context.read<PatternBloc>().add(
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
