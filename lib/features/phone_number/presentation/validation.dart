import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/phone_number/presentation/bloc/phone_number_bloc.dart';

class Validation extends StatefulWidget {
  final bool isValidating;
  final String hintText;
  final IconData icon;
  final String buttonText;
  final String? verificationId;

  Validation({
    super.key,
    required this.isValidating,
    required this.hintText,
    required this.icon,
    required this.buttonText,
    this.verificationId,
  });

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.1,
        ),
        if (widget.isValidating)
          const Text(
            'You should get text message with verification code',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )
        else
          const Text(
            'Please type in your phone number with country code (e.g. +48)',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _textEditingController,
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
                    labelText: widget.hintText,
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
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (!widget.isValidating) {
              context.read<PhoneNumberBloc>().add(
                    LoginButtonPressed(
                      phoneNumber: _textEditingController.text,
                    ),
                  );
              _textEditingController.clear();
            } else {
              context.read<PhoneNumberBloc>().add(
                    VerifyButtonPressed(
                      verificationId: widget.verificationId!,
                      smsCode: _textEditingController.text,
                    ),
                  );
              _textEditingController.clear();
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.045,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 108, 178, 186),
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
