// Flutter imports:
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscure = false,
    required this.icon,
    this.inputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscure;
  final IconData icon;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              obscureText: obscure,
              controller: controller,
              textInputAction: inputAction,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
