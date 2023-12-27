import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/phone_number/data/phone_number_firebase.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  final PhoneNumberFirebase _phoneNumberFirebase;
  PhoneNumberBloc(this._phoneNumberFirebase) : super(PhoneNumberInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<VerifyButtonPressed>(_onVerifyButtonPressed);
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

  Future<void> signOut() async {
    await _phoneNumberFirebase.signOut();
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
}
