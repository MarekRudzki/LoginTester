part of 'social_media_accounts_bloc.dart';

class SocialMediaAccountsState extends Equatable {
  const SocialMediaAccountsState();

  @override
  List<Object> get props => [];
}

class SocialMediaAccountsInitial extends SocialMediaAccountsState {}

class SocialMediaAccountsLoading extends SocialMediaAccountsState {}

class SocialMediaAccountsSuccess extends SocialMediaAccountsState {
  final String socialMediaType;

  SocialMediaAccountsSuccess({
    required this.socialMediaType,
  });

  @override
  List<Object> get props => [
        socialMediaType,
      ];
}

class SocialMediaAccountsError extends SocialMediaAccountsState {
  final String errorMessage;

  SocialMediaAccountsError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
