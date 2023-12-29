import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/anonymous/presentation/bloc/anonymous_bloc.dart';
import 'package:login_tester/success_screen.dart';

class Anonymous extends StatelessWidget {
  const Anonymous({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnonymousBloc, AnonymousState>(
      listener: (context, state) {
        if (state is AnonymousError) {
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
        } else if (state is AnonymousSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                userType: 'Anonymous Account',
                onLogOut: () async {
                  context.read<AnonymousBloc>().add(const LogoutPressed());
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.15,
          ),
          BlocBuilder<AnonymousBloc, AnonymousState>(
            builder: (context, state) {
              if (state is AnonymousInitial) {
                return ElevatedButton(
                  onPressed: () async {
                    context
                        .read<AnonymousBloc>()
                        .add(const LoginAnonomyouslyPressed());
                  },
                  child: const Text(
                    'Login anonymously',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
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
                );
              } else if (state is AnonymousLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
