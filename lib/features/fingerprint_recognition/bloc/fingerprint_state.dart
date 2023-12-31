part of 'fingerprint_bloc.dart';

class FingerprintState extends Equatable {
  const FingerprintState();

  @override
  List<Object> get props => [];
}

class FingerprintInitial extends FingerprintState {}

class FingerprintLoading extends FingerprintState {}

class FingerprintSuccess extends FingerprintState {}

class FingerprintError extends FingerprintState {
  final String errorMessage;

  FingerprintError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
