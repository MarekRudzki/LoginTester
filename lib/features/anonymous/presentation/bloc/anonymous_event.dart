part of 'anonymous_bloc.dart';

class AnonymousEvent extends Equatable {
  const AnonymousEvent();

  @override
  List<Object> get props => [];
}

class LoginAnonomyouslyPressed extends AnonymousEvent {
  const LoginAnonomyouslyPressed();

  @override
  List<Object> get props => [];
}

class LogoutPressed extends AnonymousEvent {}

class DeleteAccountPressed extends AnonymousEvent {}
