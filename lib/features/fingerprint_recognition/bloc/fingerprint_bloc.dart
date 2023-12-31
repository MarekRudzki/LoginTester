// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

part 'fingerprint_event.dart';
part 'fingerprint_state.dart';

class FingerprintBloc extends Bloc<FingerprintEvent, FingerprintState> {
  FingerprintBloc() : super(FingerprintInitial()) {
    on<FingerprintLoginPressed>(_onFingerprintLoginPressed);
    on<DeviceSupportFingerprintUpdated>(_onDeviceSupportFingerprintUpdated);
  }

  bool _supportFingerprint = true;

  bool get supportFingerprint => _supportFingerprint;

  Future<void> _onFingerprintLoginPressed(
    FingerprintLoginPressed event,
    Emitter<FingerprintState> emit,
  ) async {
    emit(FingerprintLoading());
    try {
      await event.auth
          .authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      )
          .then((isAuthenticated) {
        if (isAuthenticated) {
          emit(FingerprintSuccess());
          emit(FingerprintInitial());
        } else {
          emit(FingerprintError(errorMessage: 'Authentication failed'));
          emit(FingerprintInitial());
        }
      });
    } catch (e) {
      emit(FingerprintError(errorMessage: e.toString()));
      emit(FingerprintInitial());
    }
  }

  void _onDeviceSupportFingerprintUpdated(
    DeviceSupportFingerprintUpdated event,
    Emitter<FingerprintState> emit,
  ) {
    _supportFingerprint = event.isSupported;
    emit(FingerprintLoading());
    emit(FingerprintInitial());
  }
}
