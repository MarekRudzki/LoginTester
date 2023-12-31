// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_lock/pattern_lock.dart';

// Project imports:
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';

class PatternDrawer extends StatelessWidget {
  const PatternDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (_) {},
      onVerticalDragDown: (_) {},
      child: Container(
        height: 240,
        child: PatternLock(
          selectedColor: Colors.green,
          fillPoints: true,
          notSelectedColor: Colors.grey.shade300,
          onInputComplete: (List<int> input) {
            context.read<PatternBloc>().add(
                  PatternUpdated(
                    pattern: input,
                  ),
                );
          },
        ),
      ),
    );
  }
}
