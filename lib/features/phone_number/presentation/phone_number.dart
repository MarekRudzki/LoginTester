import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:login_tester/features/phone_number/presentation/validation.dart';
import 'package:login_tester/success_screen.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
      listener: (context, state) {
        if (state is PhoneNumberVerificationError) {
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
        } else if (state is PhoneNumberVerificationSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                userType: 'Phone number',
                onLogOut: () async {
                  context.read<PhoneNumberBloc>().add(LogoutPressed());
                  Navigator.of(context).pop();
                },
                onDeleteAccount: () async {
                  context.read<PhoneNumberBloc>().add(DeleteAccountPressed());
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PhoneNumberInitial) {
          return Validation(
            isValidating: false,
            hintText: 'Enter your phone number',
            icon: Icons.phone,
            buttonText: 'Log In',
          );
        } else if (state is PhoneNumberVerificationCodeSent) {
          return Validation(
            isValidating: true,
            hintText: 'Enter validation code',
            icon: Icons.onetwothree,
            buttonText: 'Validate',
            verificationId: state.verificationId,
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
