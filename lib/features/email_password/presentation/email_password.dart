// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/email_password/presentation/widgets/login_view.dart';
import 'package:login_tester/features/email_password/presentation/widgets/register_view.dart';

class EmailPassword extends StatelessWidget {
  const EmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final currentAuthView = context.watch<EmailPasswordBloc>().currentView;

    if (currentAuthView == AuthView.login) {
      return const LoginView();
    } else {
      return const RegisterView();
    }
  }
}
