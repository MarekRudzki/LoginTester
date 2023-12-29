part of 'anonymous_bloc.dart';

class AnonymousState extends Equatable {
  const AnonymousState();

  @override
  List<Object> get props => [];
}

class AnonymousInitial extends AnonymousState {}

class AnonymousLoading extends AnonymousState {}

class AnonymousSuccess extends AnonymousState {}

class AnonymousError extends AnonymousState {
  final String errorMessage;

  AnonymousError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
