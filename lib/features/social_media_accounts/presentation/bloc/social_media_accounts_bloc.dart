import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_tester/features/social_media_accounts/data/social_media_accounts_firebase.dart';
import 'package:twitter_login/twitter_login.dart';

part 'social_media_accounts_event.dart';
part 'social_media_accounts_state.dart';

class SocialMediaAccountsBloc
    extends Bloc<SocialMediaAccountsEvent, SocialMediaAccountsState> {
  final SocialMediaAccountsFirebase _socialMediaAccountsFirebase;
  SocialMediaAccountsBloc(this._socialMediaAccountsFirebase)
      : super(SocialMediaAccountsInitial()) {
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
    on<LoginWithTwitterPressed>(_onLoginWithTwitterPressed);
    on<LogoutPressed>(_onLogoutPressed);
    on<DeleteAccountPressed>(_onDeleteAccountPressed);
  }

  Future<void> _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
    Emitter<SocialMediaAccountsState> emit,
  ) async {
    try {
      emit(SocialMediaAccountsLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _socialMediaAccountsFirebase.signInWithGoogle(
          credential: credential);

      emit(SocialMediaAccountsSuccess(socialMediaType: 'Google'));
      emit(SocialMediaAccountsInitial());
    } on Exception catch (e) {
      emit(SocialMediaAccountsError(errorMessage: e.toString()));
      emit(SocialMediaAccountsInitial());
    }
  }

  Future<void> _onLoginWithFacebookPressed(
    LoginWithFacebookPressed event,
    Emitter<SocialMediaAccountsState> emit,
  ) async {
    try {
      emit(SocialMediaAccountsLoading());
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _socialMediaAccountsFirebase.signInWithCredential(
          credential: facebookAuthCredential);
      emit(SocialMediaAccountsSuccess(socialMediaType: 'Facebook'));
      emit(SocialMediaAccountsInitial());
    } on Exception catch (e) {
      emit(SocialMediaAccountsError(errorMessage: e.toString()));
      emit(SocialMediaAccountsInitial());
    }
  }

  Future<void> _onLoginWithTwitterPressed(
    LoginWithTwitterPressed event,
    Emitter<SocialMediaAccountsState> emit,
  ) async {
    try {
      emit(SocialMediaAccountsLoading());
      await dotenv.load();

      final twitterLogin = TwitterLogin(
        apiKey: dotenv.env['TwitterConsumerKey']!,
        apiSecretKey: dotenv.env['TwitterConsumerSecret']!,
        redirectURI:
            "https://logintester-99843.firebaseapp.com/__/auth/handler",
      );

      final authResult = await twitterLogin.login();

      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      await _socialMediaAccountsFirebase.signInWithCredential(
          credential: twitterAuthCredential);

      emit(SocialMediaAccountsSuccess(socialMediaType: 'Twitter'));
      emit(SocialMediaAccountsInitial());
    } on Exception catch (e) {
      emit(SocialMediaAccountsError(errorMessage: e.toString()));
      emit(SocialMediaAccountsInitial());
    }
  }

  Future<void> _onLogoutPressed(
    LogoutPressed event,
    Emitter<SocialMediaAccountsState> emit,
  ) async {
    await _socialMediaAccountsFirebase.signOut();
  }

  Future<void> _onDeleteAccountPressed(
    DeleteAccountPressed event,
    Emitter<SocialMediaAccountsState> emit,
  ) async {
    if (event.socialMediaType == 'Google') {
      await _socialMediaAccountsFirebase.deleteGoogleAccount();
    } else if (event.socialMediaType == 'Facebook') {
      await _socialMediaAccountsFirebase.deleteFacebookAccount();
    } else {
      await _socialMediaAccountsFirebase.deleteTwitterAccount();
    }
  }
}
