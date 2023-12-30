import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:pattern_lock/pattern_lock.dart';

class PatternDrawer extends StatelessWidget {
  const PatternDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: PatternLock(
        selectedColor: Colors.green,
        fillPoints: true,
        notSelectedColor: Colors.grey.shade300,
        selectThreshold: 20,
        onInputComplete: (List<int> input) {
          context.read<PatternBloc>().add(
                PatternUpdated(
                  pattern: input,
                ),
              );
        },
      ),
    );
  }
}
