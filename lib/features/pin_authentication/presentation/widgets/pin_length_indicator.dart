// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';

class PinLengthIndicator extends StatelessWidget {
  const PinLengthIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final pinLength = context.watch<PinAuthenticationBloc>().userPinCode.length;

    return Container(
      height: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor:
                      pinLength > index ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
