part of 'pattern_bloc.dart';

class PatternEvent extends Equatable {
  const PatternEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends PatternEvent {
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends PatternEvent {
  final String email;

  RegisterButtonPressed({
    required this.email,
  });

  @override
  List<Object> get props => [
        email,
      ];
}

class AuthViewChanged extends PatternEvent {
  final AuthView view;

  AuthViewChanged({
    required this.view,
  });

  @override
  List<Object> get props => [
        view,
      ];
}

class PatternUpdated extends PatternEvent {
  final List<int> pattern;

  PatternUpdated({
    required this.pattern,
  });

  @override
  List<Object> get props => [
        pattern,
      ];
}

class DeleteUserPressed extends PatternEvent {}
