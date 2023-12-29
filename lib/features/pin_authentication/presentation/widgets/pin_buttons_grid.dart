import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';

class PinButtonsGrid extends StatelessWidget {
  const PinButtonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: MediaQuery.sizeOf(context).width * 0.7,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 9) {
            return const SizedBox();
          }
          if (index == 11) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  context.read<PinAuthenticationBloc>().add(
                        PinCodeDeleting(operationType: 'remove'),
                      );
                },
                icon: const Icon(
                  Icons.backspace_outlined,
                  color: Colors.teal,
                ),
              ),
            );
          } else {
            return PinButton(
              digit: '${index + 1}',
              onPressed: () {
                context
                    .read<PinAuthenticationBloc>()
                    .add(PinCodeUpdated(text: '${index + 1}'));
              },
            );
          }
        },
        itemCount: 12,
      ),
    );
  }
}

class PinButton extends StatelessWidget {
  final String digit;
  final VoidCallback onPressed;

  const PinButton({
    required this.digit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            digit == '11' ? '0' : digit,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
