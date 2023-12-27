part of 'phone_number_bloc.dart';

class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends PhoneNumberEvent {
  final String phoneNumber;

  LoginButtonPressed({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyButtonPressed extends PhoneNumberEvent {
  final String verificationId;
  final String smsCode;

  VerifyButtonPressed({
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object> get props => [verificationId, smsCode];
}
