import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final void Function() onTap;

  const SocialMediaButton({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Container(
          height: 45,
          color: Colors.white,
          child: Row(
            children: [
              const SizedBox(width: 7),
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              const SizedBox(width: 7),
              const VerticalDivider(
                width: 4,
                color: Colors.teal,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
