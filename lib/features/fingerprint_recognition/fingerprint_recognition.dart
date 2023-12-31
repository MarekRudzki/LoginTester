// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

// Project imports:
import 'package:login_tester/features/fingerprint_recognition/bloc/fingerprint_bloc.dart';
import 'package:login_tester/success_screen.dart';

class FingerprintRecognition extends StatefulWidget {
  const FingerprintRecognition({super.key});

  @override
  State<FingerprintRecognition> createState() => _FingerprintRecognitionState();
}

class _FingerprintRecognitionState extends State<FingerprintRecognition> {
  late final LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
      (bool isSupported) {
        FingerprintBloc().add(
          DeviceSupportFingerprintUpdated(
            isSupported: isSupported,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSupported = context.watch<FingerprintBloc>().supportFingerprint;

    return BlocListener<FingerprintBloc, FingerprintState>(
      listener: (context, state) {
        if (state is FingerprintSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                userType: 'Fingerprint recognition',
                onLogOut: () async {
                  Navigator.of(context).pop();
                },
                onDeleteAccount: () async {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
        if (state is FingerprintError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Authentication failed',
                textAlign: TextAlign.center,
              ),
              duration: Duration(
                seconds: 3,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<FingerprintBloc, FingerprintState>(
          builder: (context, state) {
            if (state is FingerprintInitial) {
              return Column(
                children: [
                  if (isSupported)
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.3,
                        ),
                        const Text(
                          'Click the button to login with fingerprint',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            context.read<FingerprintBloc>().add(
                                  FingerprintLoginPressed(auth: auth),
                                );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.045,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 108, 178, 186),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const Text(
                      'Device is not supported with fingerprint recognition!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              );
            } else if (state is FingerprintLoading) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
