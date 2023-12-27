import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_tester/features/social_media_accounts/data/social_media_accounts_firebase.dart';

part 'social_media_accounts_event.dart';
part 'social_media_accounts_state.dart';

class SocialMediaAccountsBloc
    extends Bloc<SocialMediaAccountsEvent, SocialMediaAccountsState> {
  final SocialMediaAccountsFirebase _socialMediaAccountsFirebase;
  SocialMediaAccountsBloc(this._socialMediaAccountsFirebase)
      : super(SocialMediaAccountsInitial()) {
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
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

      emit(SocialMediaAccountsSuccess());
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

      await _socialMediaAccountsFirebase.signInWithFacebook(
          credential: facebookAuthCredential);
      emit(SocialMediaAccountsSuccess());
      emit(SocialMediaAccountsInitial());
    } on Exception catch (e) {
      print(e);
      emit(SocialMediaAccountsError(errorMessage: e.toString()));
      emit(SocialMediaAccountsInitial());
    }
  }

  Future<void> signOut() async {
    await _socialMediaAccountsFirebase.signOut();
  }
}