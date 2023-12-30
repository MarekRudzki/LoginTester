part of 'pin_authentication_bloc.dart';

class PinAuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends PinAuthenticationEvent {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends PinAuthenticationEvent {
  final String email;

  RegisterButtonPressed({
    required this.email,
  });

  @override
  List<Object> get props => [
        email,
      ];
}

class AuthViewChanged extends PinAuthenticationEvent {
  final AuthView view;

  AuthViewChanged({
    required this.view,
  });

  @override
  List<Object> get props => [
        view,
      ];
}

class PinCodeDeleting extends PinAuthenticationEvent {
  final String operationType;

  PinCodeDeleting({
    required this.operationType,
  });

  @override
  List<Object> get props => [
        operationType,
      ];
}

class PinCodeUpdated extends PinAuthenticationEvent {
  final String text;

  PinCodeUpdated({
    required this.text,
  });

  @override
  List<Object> get props => [
        text,
      ];
}

class DeleteUserPressed extends PinAuthenticationEvent {}
