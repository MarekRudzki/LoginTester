part of 'fingerprint_bloc.dart';

class FingerprintEvent extends Equatable {
  const FingerprintEvent();

  @override
  List<Object> get props => [];
}

class FingerprintLoginPressed extends FingerprintEvent {
  final LocalAuthentication auth;

  FingerprintLoginPressed({
    required this.auth,
  });

  @override
  List<Object> get props => [
        auth,
      ];
}

class DeviceSupportFingerprintUpdated extends FingerprintEvent {
  final bool isSupported;

  DeviceSupportFingerprintUpdated({
    required this.isSupported,
  });

  @override
  List<Object> get props => [
        isSupported,
      ];
}
