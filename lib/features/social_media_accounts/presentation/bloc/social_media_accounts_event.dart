part of 'social_media_accounts_bloc.dart';

class SocialMediaAccountsEvent extends Equatable {
  const SocialMediaAccountsEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends SocialMediaAccountsEvent {}

class LoginWithFacebookPressed extends SocialMediaAccountsEvent {}

class LoginWithTwitterPressed extends SocialMediaAccountsEvent {}

class LogoutPressed extends SocialMediaAccountsEvent {}

class DeleteAccountPressed extends SocialMediaAccountsEvent {
  final String socialMediaType;

  DeleteAccountPressed({
    required this.socialMediaType,
  });

  @override
  List<Object> get props => [
        socialMediaType,
      ];
}
