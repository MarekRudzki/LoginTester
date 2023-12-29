part of 'pin_authentication_bloc.dart';

class PinAuthenticationState extends Equatable {
  const PinAuthenticationState();

  @override
  List<Object> get props => [];
}

class PinAuthenticationInitial extends PinAuthenticationState {}

class PinAuthenticationLoading extends PinAuthenticationState {}

class PinAuthenticationSuccess extends PinAuthenticationState {}

class PinAuthenticationError extends PinAuthenticationState {
  final String errorMessage;

  PinAuthenticationError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
