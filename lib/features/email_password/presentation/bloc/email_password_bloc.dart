// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:login_tester/features/email_password/data/email_password_firebase.dart';

part 'email_password_event.dart';
part 'email_password_state.dart';

enum AuthView { login, register }

@injectable
class EmailPasswordBloc extends Bloc<EmailPasswordEvent, EmailPasswordState> {
  final EmailPasswordFirebase _authFirebase;

  EmailPasswordBloc(this._authFirebase) : super(EmailPasswordInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<PasswordResetPressed>(_onPasswordResetPressed);
    on<AuthViewChanged>(_onAuthViewChanged);
    on<LogoutPressed>(_onLogoutPressed);
    on<DeleteAccountPressed>(_onDeleteAccountPressed);
  }

  AuthView _currentView = AuthView.login;

  AuthView get currentView => _currentView;

  void _onAuthViewChanged(
    AuthViewChanged event,
    Emitter<EmailPasswordState> emit,
  ) {
    _currentView = event.view;
    emit(EmailPasswordLoading());
    emit(EmailPasswordInitial());
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<EmailPasswordState> emit,
  ) async {
    if (event.email.trim().isEmpty || event.password.trim().isEmpty) {
      emit(
        EmailPasswordError(errorMessage: 'Please fill in all fields'),
      );
      emit(EmailPasswordInitial());
    } else {
      emit(EmailPasswordLoading());

      try {
        await _authFirebase.logIn(
          email: event.email,
          password: event.password,
        );
        emit(EmailPasswordSuccess());
        emit(EmailPasswordInitial());
      } catch (error) {
        emit(EmailPasswordError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(EmailPasswordInitial());
      }
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<EmailPasswordState> emit,
  ) async {
    if (event.email.trim().isEmpty ||
        event.password.trim().isEmpty ||
        event.confirmedPassword.trim().isEmpty) {
      emit(EmailPasswordError(errorMessage: 'Please fill in all fields'));
      emit(EmailPasswordInitial());
    } else {
      emit(EmailPasswordLoading());
      try {
        await _authFirebase.register(
          email: event.email,
          password: event.password,
          confirmedPassword: event.confirmedPassword,
        );

        emit(EmailPasswordSuccess());
        emit(EmailPasswordInitial());
      } catch (error) {
        emit(EmailPasswordError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(EmailPasswordInitial());
      }
    }
  }

  Future<void> _onPasswordResetPressed(
    PasswordResetPressed event,
    Emitter<EmailPasswordState> emit,
  ) async {
    if (event.passwordResetEmail.trim().isEmpty) {
      emit(EmailPasswordError(errorMessage: 'Field is empty'));
      emit(EmailPasswordInitial());
    } else {
      emit(EmailPasswordLoading());
      await _authFirebase
          .resetPassword(passwordResetText: event.passwordResetEmail)
          .then((isReset) {
        if (isReset) {
          emit(EmailPasswordSuccess());
        }
      }).onError((error, _) async {
        emit(EmailPasswordError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(EmailPasswordInitial());
      });
    }
  }

  Future<void> _onLogoutPressed(
    LogoutPressed event,
    Emitter<EmailPasswordState> emit,
  ) async {
    await _authFirebase.signOut();
  }

  Future<void> _onDeleteAccountPressed(
    DeleteAccountPressed event,
    Emitter<EmailPasswordState> emit,
  ) async {
    await _authFirebase.deleteAccount();
  }
}
