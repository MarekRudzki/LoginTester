import 'package:flutter/material.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/login_selection/widgets/single_login_method.dart';

import 'package:provider/provider.dart';

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
              icon: Icons.group,
              text: 'Social Media Accounts',
              methodIndex: 3,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.phone,
              text: 'Phone Nnumber',
              methodIndex: 4,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.onetwothree,
              text: 'PIN authentication',
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
              icon: Icons.face,
              text: 'Face Recognition',
              methodIndex: 7,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.fingerprint,
              text: 'Fingerprint Recognition',
              methodIndex: 8,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.record_voice_over,
              text: 'Voice Recognition',
              methodIndex: 9,
              selectedValue: loginProvider.selectedLoginValue,
            ),
            SingleLoginMethod(
              icon: Icons.remove_red_eye_outlined,
              text: 'Iris Recognition',
              methodIndex: 10,
              selectedValue: loginProvider.selectedLoginValue,
            ),
          ],
        );
      },
    );
  }
}
