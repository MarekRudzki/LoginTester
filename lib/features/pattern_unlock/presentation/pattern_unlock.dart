import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/widgets/pattern_login_view.dart';
import 'package:login_tester/features/pattern_unlock/presentation/widgets/pattern_register_view.dart';

class PatternUnlock extends StatelessWidget {
  const PatternUnlock({super.key});

  @override
  Widget build(BuildContext context) {
    final userExists = context.read<PatternBloc>().userExistsLocal();
    final currentAuthView = context.watch<PatternBloc>().currentView;

    if (currentAuthView == AuthView.login && userExists) {
      return const PatternLoginView();
    } else {
      return const PatternRegisterView();
    }
  }
}
