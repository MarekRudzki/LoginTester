part of 'email_password_bloc.dart';

class EmailPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends EmailPasswordEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class RegisterButtonPressed extends EmailPasswordEvent {
  final String email;
  final String password;
  final String confirmedPassword;

  RegisterButtonPressed({
    required this.email,
    required this.password,
    required this.confirmedPassword,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
      ];
}

class PasswordResetPressed extends EmailPasswordEvent {
  final String passwordResetEmail;

  PasswordResetPressed({
    required this.passwordResetEmail,
  });

  @override
  List<Object> get props => [
        passwordResetEmail,
      ];
}

class AuthViewChanged extends EmailPasswordEvent {
  final AuthView view;

  AuthViewChanged({
    required this.view,
  });

  @override
  List<Object> get props => [
        view,
      ];
}
