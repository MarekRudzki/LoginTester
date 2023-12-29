import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/widgets/pin_login_view.dart';
import 'package:login_tester/features/pin_authentication/presentation/widgets/pin_register_view.dart';

class PinAuthentication extends StatelessWidget {
  const PinAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final userExists = context.read<PinAuthenticationBloc>().userExistsLocal();
    final currentAuthView = context.watch<PinAuthenticationBloc>().currentView;

    if (currentAuthView == AuthView.login && userExists) {
      return const PinLoginView();
    } else {
      return const PinRegisterView();
    }
  }
}
