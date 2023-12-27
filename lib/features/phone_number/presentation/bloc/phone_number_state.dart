part of 'phone_number_bloc.dart';

class PhoneNumberState extends Equatable {
  const PhoneNumberState();

  @override
  List<Object> get props => [];
}

class PhoneNumberInitial extends PhoneNumberState {}

class PhoneNumberVerificationSuccess extends PhoneNumberState {}

class PhoneNumberVerificationLoading extends PhoneNumberState {}

class PhoneNumberVerificationCodeSent extends PhoneNumberState {
  final String verificationId;

  PhoneNumberVerificationCodeSent({
    required this.verificationId,
  });

  @override
  List<Object> get props => [
        verificationId,
      ];
}

class PhoneNumberVerificationError extends PhoneNumberState {
  final String errorMessage;

  PhoneNumberVerificationError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
