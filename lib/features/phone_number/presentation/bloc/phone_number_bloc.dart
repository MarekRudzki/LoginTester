// Package imports:
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:login_tester/features/phone_number/data/phone_number_firebase.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

@injectable
class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  final PhoneNumberFirebase _phoneNumberFirebase;
  PhoneNumberBloc(this._phoneNumberFirebase) : super(PhoneNumberInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<VerifyButtonPressed>(_onVerifyButtonPressed);
    on<DeleteAccountPressed>(_onDeleteAccountPressed);
    on<LogoutPressed>(_onLogOutPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<PhoneNumberState> emit,
  ) async {
    emit(PhoneNumberVerificationLoading());
    final VerificationResult loginOutcome =
        await _phoneNumberFirebase.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
    );

    if (loginOutcome.status == VerificationStatus.completed) {
      emit(PhoneNumberVerificationSuccess());
      emit(PhoneNumberInitial());
    } else if (loginOutcome.status == VerificationStatus.codeSent) {
      emit(PhoneNumberVerificationCodeSent(
          verificationId: loginOutcome.verificationId!));
    } else if (loginOutcome.status == VerificationStatus.timeout) {
      emit(PhoneNumberVerificationError(errorMessage: 'Request timed out'));
      emit(PhoneNumberInitial());
    } else {
      emit(PhoneNumberVerificationError(
          errorMessage: 'Error occured: ${loginOutcome.errorMessage}'));
      emit(PhoneNumberInitial());
    }
  }

  Future<void> _onVerifyButtonPressed(
    VerifyButtonPressed event,
    Emitter<PhoneNumberState> emit,
  ) async {
    emit(PhoneNumberVerificationLoading());
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: event.verificationId,
      smsCode: event.smsCode,
    );

    try {
      await _phoneNumberFirebase.signInWithCredential(credential: credential);
      emit(PhoneNumberVerificationSuccess());
      emit(PhoneNumberInitial());
    } catch (e) {
      emit(PhoneNumberVerificationError(errorMessage: 'Error occured: ${e}'));
      emit(PhoneNumberInitial());
    }
  }

  Future<void> _onLogOutPressed(
    LogoutPressed event,
    Emitter<PhoneNumberState> emit,
  ) async {
    await _phoneNumberFirebase.signOut();
  }

  Future<void> _onDeleteAccountPressed(
    DeleteAccountPressed event,
    Emitter<PhoneNumberState> emit,
  ) async {
    await _phoneNumberFirebase.deleteAccount();
  }
}
