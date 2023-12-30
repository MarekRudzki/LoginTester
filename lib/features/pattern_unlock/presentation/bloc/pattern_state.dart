part of 'pattern_bloc.dart';

class PatternState extends Equatable {
  const PatternState();

  @override
  List<Object> get props => [];
}

class PatternInitial extends PatternState {}

class PatternLoading extends PatternState {}

class PatternSuccess extends PatternState {}

class PatternError extends PatternState {
  final String errorMessage;

  PatternError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
