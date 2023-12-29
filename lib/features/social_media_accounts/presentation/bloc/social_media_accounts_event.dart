part of 'social_media_accounts_bloc.dart';

class SocialMediaAccountsEvent extends Equatable {
  const SocialMediaAccountsEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends SocialMediaAccountsEvent {}

class LoginWithFacebookPressed extends SocialMediaAccountsEvent {}

class LoginWithTwitterPressed extends SocialMediaAccountsEvent {}
