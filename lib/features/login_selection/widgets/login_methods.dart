// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/login_selection/widgets/single_login_method.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) {
        return Column(
          children: [
            SingleLoginMethod(
              icon: Icons.account_circle,
              text: 'Anonymous',
              methodIndex: 1,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.mail_outline,
              text: 'Email & Password',
              methodIndex: 2,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.phone,
              text: 'Phone Nnumber',
              methodIndex: 3,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.group,
              text: 'Social Media Accounts',
              methodIndex: 4,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.onetwothree,
              text: 'PIN Authentication',
              methodIndex: 5,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.gesture,
              text: 'Pattern Unlock',
              methodIndex: 6,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.fingerprint,
              text: 'Fingerprint Recognition',
              methodIndex: 7,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.face,
              text: 'Face Recognition',
              methodIndex: 8,
              selectedValue: loginProvider.selectedLoginValue,
            ),
          ],
        );
      },
    );
  }
}
