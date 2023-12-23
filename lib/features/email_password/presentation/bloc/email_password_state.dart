part of 'email_password_bloc.dart';

class EmailPasswordState extends Equatable {
  const EmailPasswordState();

  @override
  List<Object> get props => [];
}

class EmailPasswordInitial extends EmailPasswordState {}

class EmailPasswordLoading extends EmailPasswordState {}

class EmailPasswordSuccess extends EmailPasswordState {}

class EmailPasswordError extends EmailPasswordState {
  final String errorMessage;

  EmailPasswordError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
