// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:login_tester/features/login_selection/provider/login_provider.dart';

class SingleLoginMethod extends StatelessWidget {
  final IconData icon;
  final String text;
  final int methodIndex;
  final int selectedValue;

  const SingleLoginMethod({
    super.key,
    required this.icon,
    required this.text,
    required this.methodIndex,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          context.read<LoginProvider>().setLoginValue(value: methodIndex);
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Radio(
              value: methodIndex,
              groupValue: selectedValue,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.grey;
                },
              ),
              onChanged: (value) {
                context.read<LoginProvider>().setLoginValue(value: value!);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
